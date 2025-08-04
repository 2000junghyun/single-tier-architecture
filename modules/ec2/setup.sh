#!/bin/bash
# 패키지 업데이트 및 기본 설치
apt-get update -y
apt-get install -y nginx python3 python3-pip

# Flask 설치
pip3 install flask

# Flask 앱 생성
cat <<EOF > /home/ubuntu/app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from Flask on Single-Tier EC2!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

# 시스템 서비스 등록
cat <<EOF > /etc/systemd/system/flask.service
[Unit]
Description=Flask App
After=network.target

[Service]
ExecStart=/usr/bin/python3 /home/ubuntu/app.py
WorkingDirectory=/home/ubuntu
Restart=always
User=ubuntu

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reexec
systemctl daemon-reload
systemctl enable flask
systemctl start flask

# Nginx 설정 (Flask와 연결)
rm /etc/nginx/sites-enabled/default
cat <<EOF > /etc/nginx/sites-available/flask
server {
    listen 80;
    location / {
        proxy_pass http://127.0.0.1:5000;
    }
}
EOF

ln -s /etc/nginx/sites-available/flask /etc/nginx/sites-enabled/
systemctl restart nginx
