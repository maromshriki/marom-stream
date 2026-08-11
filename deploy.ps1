param(
    [switch]$ValidateOnly,
    [switch]$SkipTerraform,
    [switch]$SkipDockerBuild,
    [switch]$SkipPush,
    [string]$CommitMessage = "Deploy via deploy.ps1"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$terraformDir = Join-Path $repoRoot "terraform"
$backendDockerfile = Join-Path $repoRoot "Server/MagicStreamServer/Dockerfile"
$backendContext = Join-Path $repoRoot "Server/MagicStreamServer"
$frontendDockerfile = Join-Path $repoRoot "Client/magic-stream-client/Dockerfile"
$frontendContext = Join-Path $repoRoot "Client/magic-stream-client"

function Invoke-Step {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [scriptblock]$Action
    )

    Write-Host ""
    Write-Host "==> $Name" -ForegroundColor Cyan

    & $Action

    if ($LASTEXITCODE -ne 0) {
        throw "Step failed: $Name"
    }
}

if (-not (Get-Command terraform -ErrorAction SilentlyContinue)) {
    throw "Terraform was not found. Install it before running this script."
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "Docker was not found. Install it before running this script."
}

Push-Location $repoRoot

try {

    if (-not $SkipTerraform) {

        Invoke-Step -Name "Formatting Terraform" -Action {
            terraform "-chdir=$terraformDir" fmt -recursive
        }

        Invoke-Step -Name "Initializing Terraform" -Action {
            terraform "-chdir=$terraformDir" init -input=false -upgrade
        }

        Invoke-Step -Name "Validating Terraform" -Action {
            terraform "-chdir=$terraformDir" validate
        }

        if ($ValidateOnly) {
            Write-Host "Validation completed successfully." -ForegroundColor Green
            return
        }

        Invoke-Step -Name "Planning Terraform" -Action {
            terraform "-chdir=$terraformDir" plan -out=tfplan
        }

        Invoke-Step -Name "Applying Terraform" -Action {
            terraform "-chdir=$terraformDir" apply -auto-approve tfplan
        }

        if (Test-Path "$terraformDir\tfplan") {
            Remove-Item "$terraformDir\tfplan" -Force
        }
    }

    if (-not $SkipDockerBuild) {

        Invoke-Step -Name "Building backend image" -Action {
            docker build -t maromstream-backend:latest -f $backendDockerfile $backendContext
        }

        Invoke-Step -Name "Building frontend image" -Action {
            docker build -t maromstream-frontend:latest -f $frontendDockerfile $frontendContext
        }
    }

    if (-not $SkipTerraform) {

        Invoke-Step -Name "Seeding Database" -Action {

            aws lambda invoke `
                --function-name magicstream-seed `
                --payload '{}' `
                response.json | Out-Null

            $result = Get-Content response.json | ConvertFrom-Json

            if ($result.errorMessage) {
                throw $result.errorMessage
            }

            Write-Host "Database seeded successfully." -ForegroundColor Green
        }
    }

    if (-not $SkipPush) {

        $gitRoot = git -C $repoRoot rev-parse --show-toplevel 2>$null

        if ($LASTEXITCODE -eq 0 -and $gitRoot) {

            $status = git -C $repoRoot status --porcelain

            if ($status) {

                Invoke-Step -Name "Committing changes" -Action {
                    git -C $repoRoot add .
                    git -C $repoRoot commit -m $CommitMessage
                }

                Invoke-Step -Name "Pushing changes to remote" -Action {
                    git -C $repoRoot push
                }

                Write-Host ""
                Write-Host "GitHub Actions should now start automatically." -ForegroundColor Green

            }
            else {

                Write-Host ""
                Write-Host "No local changes detected. Skipping commit and push." -ForegroundColor Yellow

            }

        }
        else {

            Write-Host ""
            Write-Host "Git repository not detected. Skipping commit and push." -ForegroundColor Yellow

        }
    }

    if (-not $SkipTerraform) {

        $app = terraform "-chdir=$terraformDir" output -raw application_url

        Invoke-Step -Name "Waiting for application" -Action {

            for ($i = 0; $i -lt 30; $i++) {

                try {

                    $response = Invoke-WebRequest `
                        -Uri $app `
                        -UseBasicParsing `
                        -TimeoutSec 5

                    if ($response.StatusCode -eq 200) {

                        Write-Host "Application is healthy." -ForegroundColor Green
                        break

                    }

                }
                catch {

                    Start-Sleep 10

                }

            }

        }

        Write-Host ""
        Write-Host "==========================================" -ForegroundColor Green
        Write-Host " Deployment Completed Successfully"
        Write-Host "==========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Application URL: $app" -ForegroundColor Cyan
    }

}
finally {

    Pop-Location

}