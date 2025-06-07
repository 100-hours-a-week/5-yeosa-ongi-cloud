#!/bin/bash

# 도커 설치 스크립트 (Ubuntu 전용)
apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release

# GPG 키 추가
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# 도커 저장소 추가 (Ubuntu focal)
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# 설치 및 서비스 실행
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable docker
systemctl start docker

#!/bin/bash

# Git 설치
sudo apt update -y
sudo apt install -y git