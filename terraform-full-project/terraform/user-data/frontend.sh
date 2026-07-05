#!/bin/bash
set -euo pipefail
sudo yum update -y
sudo yum install -y nginx git amazon-cloudwatch-agent amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo systemctl enable amazon-cloudwatch-agent
sudo systemctl start amazon-cloudwatch-agent
cat > /etc/nginx/conf.d/default.conf <<'EOF'
server {
  listen 80;
  server_name _;
  location / {
    root /usr/share/nginx/html;
    try_files $uri $uri/ =404;
  }
}
EOF
sudo systemctl enable nginx
sudo systemctl start nginx
