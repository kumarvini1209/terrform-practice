#!/bin/bash
set -euo pipefail
sudo yum update -y
sudo yum install -y java-17-amazon-corretto git amazon-cloudwatch-agent amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo systemctl enable amazon-cloudwatch-agent
sudo systemctl start amazon-cloudwatch-agent
cat > /etc/systemd/system/backend.service <<'EOF'
[Unit]
Description=Spring Boot Backend
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/app
ExecStart=/usr/bin/java -jar /home/ec2-user/app/backend.jar
Restart=always
Environment=SPRING_PROFILES_ACTIVE=prod

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable backend
