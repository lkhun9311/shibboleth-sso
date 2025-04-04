#!/bin/bash

# 스크립트 실행 중 오류 발생 시 즉시 종료
set -e

# mod_shib 활성화
echo ">>> Enabling mod_shib."
if ! a2enmod shib | grep -q "already enabled"; then
    echo ">>> mod_shib enabled. Restarting Apache is required."
fi

# Apache Configuration 유효성 검사
echo ">>> Checking Apache configuration."
if ! apachectl configtest; then
    echo ">>> ERROR: Apache configuration is invalid. Fix errors before restarting."
    exit 1
fi

# Shibboleth 서비스 시작
echo ">>> Starting Shibboleth daemon."
if ! pgrep -x "shibd" > /dev/null; then
    service shibd start
    sleep 2  # Shibboleth가 안정적으로 시작될 시간을 확보
else
    echo ">>> Shibboleth daemon is already running."
fi

# Apache를 포그라운드 모드에서 실행하여 컨테이너 유지
echo ">>> Keeping Apache running in foreground."
exec /usr/sbin/apache2ctl -D FOREGROUND

# Apache 실행 상태 확인
echo ">>> Checking if Apache is running."
if pgrep -x "apache2" > /dev/null || pgrep -x "httpd" > /dev/null; then
    echo ">>> Apache is running successfully."
else
    echo ">>> ERROR: Apache failed to start. Checking logs."
    tail -50 /var/log/apache2/error.log
    exit 1
fi

# 실행 중인 프로세스 확인 (shibd, apache, httpd)
echo ">>> Checking running processes for Shibboleth and Apache."
ps aux | grep -E "shibd|apache|httpd" | grep -v grep

# 만약 Apache가 종료되면 오류 로그 출력
echo ">>> ERROR: Apache terminated unexpectedly!"
tail -50 /var/log/apache2/error.log
exit 1