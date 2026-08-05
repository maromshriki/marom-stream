# 🚀 MagicStream – Production-Ready Cloud Infrastructure

## Overview

MagicStream is a cloud-native streaming application deployed on AWS using Infrastructure as Code and modern DevOps practices.

The project demonstrates how to provision, secure, build, scan, and deploy a production-style environment using Terraform, Docker, GitHub Actions, and AWS services.

The primary goal of this project was not only to deploy an application, but also to design a secure, scalable, and automated infrastructure similar to what would be expected in a real production environment.

---
#  Architecture

![AWS Architecture]("./images/marom-stream.drawio.png")

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
