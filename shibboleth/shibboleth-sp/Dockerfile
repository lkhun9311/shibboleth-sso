FROM ubuntu:24.04

# 환경 변수 설정
ENV DEBIAN_FRONTEND=noninteractive
ENV container docker

# 시스템 패키지 업데이트 및 필수 패키지 설치
RUN apt update && \
    apt install -y vim apache2 openssl wget unzip nano iputils-ping \
    software-properties-common curl libxml2-utils cron python3 dos2unix && \
    add-apt-repository universe

# Shibboleth 저장소 추가 (Ubuntu 24.04 - Noble 지원)
RUN echo "deb [signed-by=/usr/share/keyrings/shibboleth-archive-keyring.asc] http://pkg.switch.ch/switchaai/ubuntu noble main" | tee /etc/apt/sources.list.d/shibboleth.list && \
    apt update

# Shibboleth 패키지 설치
RUN apt install -y libapache2-mod-shib

# SSL 인증서 생성
RUN mkdir -p /etc/shibboleth/certs && \
    openssl req -new -x509 -days 365 -nodes \
    -out /etc/shibboleth/certs/sp-cert.pem \
    -keyout /etc/shibboleth/certs/sp-key.pem \
    -subj "/C=KR/ST=Seoul/L=JungGu/O=Innogrid/OU=Innogrid.com/CN=localhost" && \
    chown _shibd:_shibd /etc/shibboleth/certs/sp-key.pem

## Apache 및 Shibboleth 설정 파일 복사
COPY shibboleth.conf /etc/apache2/sites-available/shibboleth.conf
COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
COPY attribute-map.xml /etc/shibboleth/attribute-map.xml
COPY attribute-policy.xml /etc/shibboleth/attribute-policy.xml

## Apache 및 Shibboleth 서비스 설정 적용
RUN if [ -f /etc/apache2/sites-available/shibboleth.conf ]; then a2ensite shibboleth; fi && \
    echo "ServerName shibboleth-sp" >> /etc/apache2/apache2.conf && \
    a2enmod ssl headers shib

## Shibboleth Listener 소켓 디렉토리 생성 및 권한 설정
RUN mkdir -p /var/run/shibboleth && \
    chown _shibd:_shibd /var/run/shibboleth && \
    chmod 755 /var/run/shibboleth

## shibboleth 디렉터리와 파일의 소유권 및 권한 변경
RUN chown -R _shibd:_shibd /etc/shibboleth && \
    chmod 755 /etc/shibboleth

## 실행 스크립트 복사 및 실행 권한 부여
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && dos2unix /entrypoint.sh

# 포트 노출
EXPOSE 80 443

## 컨테이너 실행 시 Apache 및 Shibboleth 시작
ENTRYPOINT ["/entrypoint.sh"]