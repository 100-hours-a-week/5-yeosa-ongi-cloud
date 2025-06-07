#!/bin/bash

# OpenVPN 설치 스크립트 다운로드
curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod +x openvpn-install.sh

# 환경변수 설정을 통해 자동 설치 + 사용자 생성까지 포함
export AUTO_INSTALL=y
export APPROVE_INSTALL=y
export APPROVE_IP=y
export IPV6_SUPPORT=n
export PORT_CHOICE=1
export PROTOCOL_CHOICE=1
export DNS=1
export COMPRESSION_ENABLED=n
export CUSTOMIZE_ENCRYPTION=n
export CLIENT=seoyoung  # 클라이언트 이름
export PASS=1            # 비밀번호 없이 연결

# 스크립트 실행
sudo ./openvpn-install.sh
