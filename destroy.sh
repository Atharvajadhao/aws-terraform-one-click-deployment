#!/bin/bash

# Infrastructure Teardown Script
# Destroys all AWS resources created by Terraform

set -e

echo "========================================="
echo "  Infrastructure Teardown"
echo "========================================="
echo ""

# Navigate to terraform directory
cd "$(dirname "$0")/terraform"

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "❌ Error: Terraform is not installed."
    exit 1
fi

# Warning message
echo "⚠️  WARNING: This will destroy all deployed infrastructure!"
echo ""
read -p "Are you sure you want to continue? (yes/no): " confirmation

if [ "$confirmation" != "yes" ]; then
    echo "Teardown cancelled."
    exit 0
fi

echo ""
echo "🗑️  Destroying infrastructure..."
terraform destroy -auto-approve

echo ""
echo "========================================="
echo "  ✅ Teardown Complete!"
echo "========================================="
echo ""
echo "✅ All AWS resources have been destroyed"
echo "✅ No further charges will be incurred"
echo ""
