# AWS One-Click Deployment

Automated AWS infrastructure deployment using Terraform. Deploys a REST API on private EC2 instances behind an Application Load Balancer with Auto Scaling.

## Architecture

```
Internet → ALB (Public) → Auto Scaling Group → EC2 Instances (Private) → NAT Gateway
```

## Features

- One-click deployment with Terraform
- High availability across multiple AZs
- Auto Scaling (1-3 instances)
- Private EC2 instances (no public IPs)
- Application Load Balancer with health checks
- Python Flask REST API

## Tech Stack

- **Infrastructure**: Terraform, AWS (VPC, EC2, ALB, ASG)
- **Application**: Python, Flask
- **Automation**: Bash scripts

## Quick Start

### Prerequisites

- Terraform (>= 1.0)
- AWS CLI configured with credentials
- AWS account with appropriate permissions

### Deploy

```bash
./deploy.sh
```

Deployment takes ~5-8 minutes.

### Test

```bash
# Get the URL
cd terraform
terraform output alb_url

# Test endpoints
curl http://<ALB-URL>/
curl http://<ALB-URL>/health
```

### Destroy

```bash
./destroy.sh
```

## Project Structure

```
.
├── app/                # Python Flask API
├── terraform/          # Infrastructure as Code
├── deploy.sh          # Deployment script
└── destroy.sh         # Teardown script
```

## Security

- EC2 instances in private subnets
- Security groups with minimal access
- IAM roles with least privilege
- No hardcoded credentials

## Cost

Approximately $0.10/hour while running. Remember to destroy resources after testing.

## License

MIT
