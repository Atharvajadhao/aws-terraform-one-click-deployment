#!/bin/bash

# One-Click Deployment Script
# Deploys complete AWS infrastructure using Terraform

set -e

echo "========================================="
echo "  AWS Infrastructure Deployment"
echo "========================================="
echo ""

# Check prerequisites
echo "Checking prerequisites..."

if ! command -v terraform &> /dev/null; then
    echo "❌ Error: Terraform is not installed."
    echo "   Install from: https://www.terraform.io/downloads"
    exit 1
fi

if ! command -v aws &> /dev/null; then
    echo "❌ Error: AWS CLI is not installed."
    echo "   Install from: https://aws.amazon.com/cli/"
    exit 1
fi

if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ Error: AWS credentials are not configured."
    echo "   Run: aws configure"
    exit 1
fi

echo "✅ All prerequisites met"
echo ""

# Navigate to terraform directory
cd "$(dirname "$0")/terraform"

# Initialize Terraform
echo "🔧 Initializing Terraform..."
terraform init
echo ""

# Validate configuration
echo "📋 Validating configuration..."
terraform validate
echo ""

# Plan deployment
echo "📊 Planning deployment..."
terraform plan -out=tfplan
echo ""

# Apply deployment
echo "🚀 Deploying infrastructure..."
echo "   This will take approximately 5-8 minutes..."
echo ""
terraform apply tfplan

# Clean up plan file
rm -f tfplan

# Display outputs
echo ""
echo "========================================="
echo "  ✅ Deployment Complete!"
echo "========================================="
echo ""
terraform output
echo ""
echo "🎉 Your application is now live!"
echo ""
echo "Test your endpoints:"
echo "  curl \$(terraform output -raw alb_url)/"
echo "  curl \$(terraform output -raw alb_url)/health"
echo ""
echo "⚠️  Remember to run './destroy.sh' when done to avoid AWS charges!"
echo ""
