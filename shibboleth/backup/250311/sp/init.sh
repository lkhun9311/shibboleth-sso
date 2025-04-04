#!/bin/bash
set -e  # 오류 발생 시 즉시 종료

# default-ssl.conf 활성화
echo ">>> Enabling SSL and default-ssl site"
a2enmod shib
a2enmod ssl
a2ensite default-ssl.conf

# Apache 재시작
echo ">>> Restart Apache"
#apachectl restart
service apache2 restart

# Apache 리로드
echo ">>> Reloading Apache"
service apache2 reload

# 권한 확인 및 Shibboleth 시작 전 파일 확인
echo ">>> Checking Shibboleth configuration files"
if [[ ! -f /etc/shibboleth/shibboleth2.xml ]]; then
    echo "❌ ERROR: /etc/shibboleth/shibboleth2.xml NOT FOUND!"
    exit 1
fi

# `shibboleth2.xml`의 권한 수정 (필요할 경우)
echo ">>> Fixing shibboleth2.xml permissions"
chown _shibd:_shibd /etc/shibboleth/shibboleth2.xml
chmod 644 /etc/shibboleth/shibboleth2.xml

# Shibboleth 서비스도 함께 실행
echo ">>> Start Shibboleth Service"
shibd -f

# 컨테이너를 foreground 모드에서 유지
echo ">>> Initialization completed! Starting Apache in foreground"
exec apachectl -D FOREGROUND
