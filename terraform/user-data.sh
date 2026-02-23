#!/bin/bash
# User data script to install and run the Python application

# Update system packages
yum update -y

# Install Python 3 and pip
yum install -y python3 python3-pip

# Create app directory
mkdir -p /opt/app
cd /opt/app

# Decode and save the application code
echo "${app_code}" | base64 -d > app.py

# Install Flask
pip3 install flask

# Create systemd service file
cat > /etc/systemd/system/app.service <<'EOF'
[Unit]
Description=REST API Application
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/app
ExecStart=/usr/bin/python3 /opt/app/app.py
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable and start the service
systemctl daemon-reload
systemctl enable app.service
systemctl start app.service

# Log the status
systemctl status app.service
