#!/bin/bash

set -e  # 스크립트 실행 중 오류 발생 시 즉시 종료

echo ">>> Ensuring Shibboleth socket directory exists..."
mkdir -p /var/run/shibboleth
chown root:root /var/run/shibboleth
chmod 750 /var/run/shibboleth

# `mod_shib` 활성화 (이미 활성화된 경우 메시지 무시)
echo ">>> Enabling mod_shib..."
#if ! a2enmod shib 2>&1 | grep -q "already enabled"; then
if ! a2enmod shib | grep -q "already enabled"; then
    echo ">>> mod_shib enabled. Restarting Apache is required."
fi

# Apache 설정 유효성 검사
echo ">>> Checking Apache configuration..."
if ! apachectl configtest; then
    echo ">>> ERROR: Apache configuration is invalid. Fix errors before restarting."
    exit 1
fi

# Shibboleth 서비스 시작
echo ">>> Starting Shibboleth daemon..."
if ! pgrep -x "shibd" > /dev/null; then
    /usr/sbin/shibd -f &
    sleep 2  # Shibboleth가 안정적으로 시작될 시간을 확보
else
    echo ">>> Shibboleth daemon is already running."
fi

# Apache 서비스 시작
#echo ">>> Restarting Apache..."
#/usr/sbin/apache2ctl restart

# Apache를 포그라운드 모드에서 실행하여 컨테이너 유지
echo ">>> Keeping Apache running in foreground."
exec /usr/sbin/apache2ctl -D FOREGROUND

# Apache 실행 상태 확인
echo ">>> Checking if Apache is running..."
if pgrep -x "apache2" > /dev/null || pgrep -x "httpd" > /dev/null; then
    echo ">>> Apache is running successfully."
else
    echo ">>> ERROR: Apache failed to start. Checking logs."
    tail -50 /var/log/apache2/error.log  # 또는 /var/log/httpd/error.log
    exit 1
fi

# 실행 중인 프로세스 확인 (shibd, apache, httpd)
echo ">>> Checking running processes for Shibboleth and Apache."
ps aux | grep -E "shibd|apache|httpd" | grep -v grep

## Apache를 포그라운드 모드에서 실행하여 컨테이너 유지
#echo ">>> Keeping Apache running in foreground."
#exec /usr/sbin/apache2ctl -D FOREGROUND

# 만약 Apache가 종료되면 오류 로그 출력
echo ">>> ERROR: Apache terminated unexpectedly!"
tail -50 /var/log/apache2/error.log  # 또는 /var/log/httpd/error.log
exit 1
