# 🚀 MagicStream – Production-Ready Cloud Infrastructure

## Overview

MagicStream is a cloud-native streaming application deployed on AWS using Infrastructure as Code and modern DevOps practices.

The project demonstrates how to provision, secure, build, scan, and deploy a production-style environment using Terraform, Docker, GitHub Actions, and AWS services.

The primary goal of this project was not only to deploy an application, but also to design a secure, scalable, and automated infrastructure similar to what would be expected in a real production environment.

---
#  Architecture
https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=marom-stream.drawio&dark=auto#R%3Cmxfile%3E%3Cdiagram%20name%3D%22%E2%80%AB%D7%A2%D7%9E%D7%95%D7%93-1%E2%80%AC%22%20id%3D%22QuO_K3pmR_jB3RRzw_6H%22%3E7V1bc%2BK4Ev41PIayfPdjgGQmVclsapizs3teKGELcMVYrGySsL%2F%2BSLYFtqUEAxb4zJDMbrCsi91fq9Xqi%2BgZw%2BX7FwJXiyccoKina8F7zxj1dF3XXJP%2BYSWbvAQAvSiZkzAoynYF4%2FBflBcavHQdBiipVEwxjtJwVS30cRwjP62UQULwW7XaDEfVUVdwjoSCsQ8jsfRnGKSL4sUMw9vd%2BIrC%2BaIY2jA0Lb%2BzhLx2UZAsYIDfSkXGXc8YEozT%2FNPyfYgiRj5OmLzd%2FQd3t09GUJw2afAaWJv%2Fet%2B%2BpwB7f1nWjPzzYt1YxcOhQKDDrt%2BiKEk3nCz%2Bmrwi1i%2FoGYMkhSS9ZcSmBTGOaZ0BigNeMo2w%2F8KK3sP0L3qt9R2ruPy76IGORDb5PWDxa3ZToxcEr%2BMgG4xd5Y%2FyCqN18ShbSlImRHiJaEtagaAIpuFr9Z1gwQzzbb2iKX1UuClVWOEwTpNSz8%2BsgFYoGBt4rpV3WfA1RR1UiV9roWtAO7SFUR1Dtx2j3IJ%2ByJ%2F7o%2Fau19ctbftT780z%2Bl7px6rSiGI6R2nRZ2XQEp13RRmvHcB3ttWEzZK3cBnBjKEyJivkg8EYYRZG0RBHmGRVjZnFfrOKBL%2Bg0h3X8WzI7izSZVQw3AzH6bgYB8i46j8JIpQBNPbiuvYQp4jEiFH3EW4QKaojkqL30rOLbLgoiQbA59rbTpAAk4uLoh9Xq7IJsHmBjHkrqBwMgS1C8ClWZWAWcMU%2BLt%2FnTPD34Vti9tcZzSp0ZiQKqTR9hFMUPeMkTEMcM5mA0xQvSxVuo3DObqR49QkcR1DdEYnuVEluVyluWqro7bRMbyoYUzSxDDUkv13Cf2lDXfvOhqF%2F6UA6ZRkDsNk3%2BjY%2BCg5XhMOtwqFbNTyU8b%2FbMh4%2BI%2ByMkpaisoQx1QyIImh%2BUuJrw91w9OqpGHAH0dcfP57HWxH241EVYObZAPNaBuwNzlQC9PP2XhHJ7XORHIATJgmVG1EY06WYq%2BaMKwOYLLbK3JH0hsWVj9i6XIVQArSxXZlqOsPtkP3Sclo1CGln%2FF6hxAq4HgWnbQhw8qWXw6lX0LR0VWjKlPvGM%2BgFpf6iAE4KLVOqStSlv%2Ffs4T6irqCozbIfEaZtR414ZxkGAXtmgXe2TPUZ%2B7wtwhSNV9Bnb%2F1GOYgri7nmCfh7lpXHhFYP4zlTTOUMaPZXBAdrP33w2SMOViT%2F8OFy3mwxPkYHBd1Zf4FuXLmxs9yYr40tr2xAO3xpU6WOA12yBe0O%2B20b1Pe5nC1VL6RlPtNrfMaGhMkqf9tZ%2BM6eQ85qBCV4TXxU8Bq9lDFbAFM4QbFPNiv24JMXtJEx34hWKym4uwalQtb0qFVaF1dpvarn8g0D35p7ijjTOcQml1H3M%2Ba1BeZl%2FXIkMUkXeI5jGN3tSksmN1C15fkRTJLQr3JKPkBuMPrsSRwB0GKLcpIB7zRSgzZJ7XSG1K44d75dltB6m4R2O0NoTyD0XS6V6Ei0PYEzukO%2FKOElSlZzQ6suLkDInZkzV7ZkAdNBU0OyinxmaM0Vij%2Bfh8xScaf3qDrgmfTzCAWZaYOR8Xa1ithFJum1byh9w%2BTlKClvScyB%2B22wjq1KB3bMhjoIh3E%2FZnQplCkNGrJlmAWubYNDMXteTyPG1dp4PY1RurOTF9Aw9fMkSzlX%2BsooGXZtn1IFyVIGUVM1kWO5z%2BoEd9w8iTAMJlNIYfSVGQsrk%2BeRDkj%2FDPiQO8WJ%2BzhuZvn%2BoSXLlVdFzXLPpN47Tb0bTWFLkL8mYbqZzOlKslKD1bgYg5Z%2BYaMkJXy2Yk%2BDvo8SNumoJk3nc6QIKs84104MnDDFumNkLPQIYU7XZPG95VqGqdroyPWt8nbGq85ET%2Btb5wHYaer5Om2Vo5qJhTzpZho5QabLHLTKkfA1961URWh90Rvi5So3yp2w4jmHr3g6UIZXU6O%2FI%2B54pLIT%2BboagXlPKIpUl2cgrVPM0KGNcv0jk6AlAfodQT%2FNUBswVWUexu%2Blu1SApJAKEkL5i3V3N2RDhTFlOjqPj%2FM9exJls6Zr1r3PljJMmzrPLo7pAPovDSH9wm5%2FCdmsvH1%2BuDya9Z2DMjT56t0ammFA%2B2HaDYyDSa5gFD7sZTaACqAfbp96zKMRobKe84hgwqbpiorfMEJz1BZYNfUGaN6ZwAKgqdtNhlbZ0lzEpdEb1oD%2Bo88%2FzP%2BzaNUhK%2Bkzq7ZQKCtzxEIgVqN%2FgGyEeqGszBELgViNXfGnrhbKyhxLfOJ6ayBpDWqt6b8DDfc1ZeNu5LDZ%2F5nj6Fey0EMqiidJLoj11rRU1xNmqVvVUl1wtkmqXyfpdZJeJ%2BkRk1S3rdpWUt001duapteggfaDBvZqkQJH5ub%2Fh6Id45hc8%2Bcmrqdd66PMIOK2uhZvAEBNZ%2BdeXwWs29jYf2Xds7NugnyC0qQUuPsBr47zir1SyO0xBp%2F9gVigbvBRx5nGVff55XSf0cgwzeFvo%2FscvvQct6C4wrTlRbsFRT%2FPtHUbmxVOdR57cufx1HVtbXq0WT0P5zrFam6Iy%2Fs%2Bq7nJBW%2F7cDQVohw3iU3O39D5HiBiiDAEFnIDUwaDq08N21Zjo3vC8RyPBiX73DMiSZikmUamwYpnJMgAVaKmbQM3ePqkqwrFpkHJx6E4c33k%2B%2FLJZLFMGiUofkdBmFQxnGGyZLZwWtGH%2FuI4K6vMa6VXgXOtMwEHtKYeDhlyVyWmk0rM0NOtIsf8d1BiAuyvmboSTCdvYbqYLJn0pRc%2BXq6okJ2GEdskn0%2BXsXgYgfLJC9qavNe9cft7Yz%2FC6yBBkDAqf5KcNGT1xnm9oxjS6e9VBEy9vp70ldkawQnRmd2JS3pd%2BZMYppM51brf2HERXY1Ics0qtDe6KlUdgMbRgZ1GNiTpGkaTVb6lmmTz9FL4Wqa4mnh8bhbd3BhnQ5j3%2FGnCweeQ70tDcE5PQ9iyTYs5Cdu1tOVDcoQTZgyu%2FnNRXA9IyykonCEjdGTWOnLr7iPFh9HwU6raSU7xTuaKlhiBU7VifMEpFVpZTBRB%2F6xRkp7IGqdttq0WCc9ftwOEF9OvWKbbRSlt%2F5qUFkVdFgjImTu5KM2dNmneGbHC7Zz1vAW0tQBuMxQuSHv316S9IdB%2BmFvvukBzyR7%2BtDPdfGQiqbEUBsC0nAM9D0MqGO6H9NMpLgdJ3szeBEKqKanSc3kM6367icjD9T3FFFK27K8QSTJbgAI79Ai9ogivjqT9%2FqPcrKoeqSwKyWu6l2hMdXYwqaoMwC9h%2BnU9pWXf0Yr1gslxRyTsTxnTa%2Fs7ZUmZnt42AHMEVZP%2F1mc9lP0wW4mkBI36wWzq0GjsM9uPxsWyEUSYtD8eRsNyhuw2X0ERYLZzLsCaGjabAoZ8VdnL3LZ8N%2Fwuy%2B%2FJlJt5mKTKZJpbTxNRBkrTLNimoCSbJEXL5BxnUY7zoXqycyjHYzZtArSK8OboQM79OAFQTxVQZz0%2BQd51x3qcz9mO%2BgI8rZ6drOwMDqA3dQbIJl7bvkeZh3EkbIGKyp3zfWehE4jcvaI8guID5qOyKdtzT3wctMdVkoM2TbuvmdU11u571XO8FOYqNHZq72Gsa0RKqxEpV3J2JsDnzgGWM%2Fg05qJzQu6EAB9RJWtpQW0Qlsx93lzsqTIDAm4E6OJ6%2BgG%2F%2Ff%2Bvp1XGmiR0y8wOmDo%2Fo9ncP6BcDTdO2DDtBVeyVdqDs5SjauynaYO7e10G4r9rgvrzMJ2QnZGutdAMSQZn3XB3Lstpm35IvgO8vF%2FG%2BwCF8zhevDYdjdy23QGi6hclapseRG6v7gBRRQ%2FiPQoQKY7ahOt0cVGqe21SXQzeuxTVTYHqz%2BtkwaixhPkRN5ei%2BDb%2FuR2Siyf0XYrkYvTTKLNBXpbYoE1idzkOR3Lk1uWorn9M5KMiE5CL4EyaE2l4pgcPzYl8wjHT%2BPJDznq6DZe5rV37Y5og8gqLxI%2BTAhd00YK%2BP3Bhe1yrAkya%2BqC26O314bLoI%2FoJqfF0PBP26gu0Lntwy8gds50S8x1qbg2nnu%2BgzFqpNd1OHQBImKyiLOVAhcOWwBnd3Za%2FlI5u36cYkuDIrwrcCwYQvsVTGRpGU6eEDI1cqZDYE0owVI2gI9mOtm6uKLodhUvK7fdROKX%2Fzzau7GUxnRpUNN0XsPST13l7G1i972rlHzHXwK6ZuzQu4Hnet93Xyl932sJaM8C3P%2F4c3D74j5PxjX3nkifLvmkaGSSdRNdEtt8okc08m2Bv0%2BYCjNM3VUdkvZRQesTz3eHLjEShf6p2WTStf8uzXstL0e16hovixBSgdSyEXEm%2BkiZujp9agfXEadOmAWj7kp0jvmSbXFGjLkZ%2Fo82srG1SXNfob4j2OEXCrPbNG3RBsqudNE3X64BcNCQRWOKGvrNOnsV6ykNfZB6%2BdpRmRwyH4ekjWyBrEcK6CQ4%2F4aHHTuHHaRlh9rZP9P1Yjf8B%3C%2Fdiagram%3E%3C%2Fmxfile%3E
![AWS Architecture]("images/marom-stream.drawio.png")

# Security Architecture

```
                 GitHub
                    │
             GitHub Actions
                    │
     ┌──────────────┴──────────────┐
     │                             │
 Secret Scan                 Terraform Validation
 (Gitleaks)                 (fmt / validate / TFLint)
     │                             │
     └──────────────┬──────────────┘
                    │
              Security Scans
         Checkov + Trivy IaC
                    │
              Docker Build
                    │
          Trivy Image Scan
                    │
             AWS OIDC Login
                    │
              Push Images
                  to ECR
                    │
              Auto Deployment
                    │
     Application Load Balancer
                    │
           Auto Scaling Groups
          Frontend / Backend
                    │
               MongoDB Cluster
```

---

# Technologies

### Cloud

* AWS EC2
* Application Load Balancer
* Auto Scaling Groups
* VPC
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* IAM
* Amazon ECR
* CloudWatch
* VPC Flow Logs

---

### Infrastructure as Code

* Terraform
* Modular Terraform Design
* Remote-ready Architecture

---

### Containers

* Docker
* Multi-stage Docker Builds
* Distroless Runtime Images

---

### CI/CD

* GitHub Actions
* OIDC Authentication
* Automated Docker Build
* Automated Image Push
* Infrastructure Validation

---

### Security

* Gitleaks
* Trivy
* Checkov
* TFLint

---

# Infrastructure

The infrastructure is fully managed with Terraform modules.

Modules include:

* Network
* Security
* Compute
* Database
* ECR
* GitHub OIDC

Every environment can be recreated from scratch using Terraform.

---

# CI/CD Pipeline

Every push to the main branch automatically performs:

## Source Code Validation

* Checkout Repository

## Secret Detection

Gitleaks scans the repository for:

* AWS Keys
* API Tokens
* Passwords
* Secrets

before anything is built.

---

## Terraform Validation

The pipeline executes:

* terraform fmt
* terraform init
* terraform validate

ensuring Infrastructure as Code quality.

---

## Infrastructure Security

Infrastructure is scanned using:

### TFLint

Checks Terraform best practices.

### Checkov

Scans AWS resources against security benchmarks.

Examples:

* Public Resources
* IAM Policies
* Encryption
* Logging
* Network Exposure

### Trivy IaC

Detects Infrastructure misconfigurations before deployment.

---

## Docker Build

Backend and Frontend images are built independently using a matrix strategy.

---

## Container Security

Every container image is scanned with Trivy.

Only images without critical exploitable vulnerabilities are allowed to continue.

---

## Authentication

GitHub authenticates to AWS using OpenID Connect (OIDC).

No long-lived AWS Access Keys are stored inside GitHub.

Benefits:

* Temporary credentials
* Automatic expiration
* Reduced attack surface
* AWS recommended authentication model

---

## Image Registry

Images are pushed into Amazon ECR.

Each image receives:

* Immutable Commit SHA tag
* Stable application tag

This enables rollback while keeping a latest deployment tag.

---

# Security Design

Security was one of the main goals of this project.

Implemented protections include:

* Least Privilege IAM
* OIDC Authentication
* Docker Multi-stage Builds
* Distroless Runtime Images
* Secret Detection
* IaC Security Scanning
* Vulnerability Scanning
* Security Groups
* VPC Isolation
* Flow Logs
* Image Scanning

---

# Challenges

## Trivy

One challenge involved container vulnerability scanning.

Several Critical vulnerabilities originated from the Debian base image rather than the application itself.

After investigation:

* Go runtime was upgraded
* Multi-stage builds were improved
* Runtime image was migrated to Distroless
* Remaining issues were identified as upstream operating system vulnerabilities.

---

## Terraform

Building reusable Terraform modules required careful dependency management between:

* VPC
* Security Groups
* Load Balancer
* Auto Scaling
* IAM
* MongoDB

Outputs and variables were refactored several times to avoid circular dependencies.

---

## GitHub OIDC

Migrating from AWS Access Keys to GitHub OIDC required creating:

* IAM OIDC Provider
* Trust Policies
* GitHub IAM Role
* Least Privilege Permissions

The result is a significantly more secure deployment pipeline.

---

# Lessons Learned

During this project I gained practical experience in:

* AWS Architecture
* Infrastructure as Code
* Cloud Security
* DevSecOps
* CI/CD Automation
* Docker Security
* IAM Design
* Terraform Modules
* Production Deployment

---

# Future Improvements

Planned improvements include:

* Kubernetes (EKS)
* Helm Charts
* Prometheus
* Grafana
* WAF
* Route53
* ACM Certificates
* Blue/Green Deployment
* Canary Deployments
* AWS Secrets Manager
* CloudFront
* Automated Rollback

---

# Project Goals

This project was built to simulate how a modern DevOps team designs and secures cloud infrastructure using AWS and Infrastructure as Code.

The focus was not only to deploy an application, but also to automate, secure, validate, and continuously improve the entire deployment lifecycle.



# MaromStream 

Movie streaming platform with AI recommendation built with modern web technologies (React/Go/gin-gonic/MongoDB) 

---

## About  

This project is a full-stack simulation of a modern **Movie Streaming Platform**, designed to showcase how different technologies can be combined to deliver a scalable, AI-powered application.  

The system brings together a **React-based frontend** for an engaging user experience, a **Go-based backend** for high-performance API services that runs on the gin (gin-gonic) web framework, and an **AI-powered recommendation engine** to personalize movie suggestions using **LangChainGo** and **OpenAI**.  

It also demonstrates how **MongoDB** can serve as a reliable, scalable database solution for managing media metadata and user preferences.  

---

## Features

- Movie Streaming service simulated on the front end using React and React-Player
- Web API service written using GO and runs on the gin-gonic web framework 
- AI Recommendation service using LangChainGo, Go and OpenAI
- Scalable backend storage provided by MongoDB

---

## Tech Stack

| Frontend / Client | JavaScript / React |
| Backend / Server | Go / gin-gonic |
| Storage / Database | MongoDB |
 
---

## Link to Video Tutorial on How to Build the App
- https://youtu.be/jBf7of9JTV8

---

### Installation

1. Clone the repo  
   ```bash
   git clone https://github.com/GavinLonDigital/MagicStream.git
   cd MagicStream
