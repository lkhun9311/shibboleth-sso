## Ubuntu 22.04 (Jammy Jellyfish) 기반 이미지 사용
#FROM ubuntu:22.04
#
## 환경 변수 설정
#ENV DEBIAN_FRONTEND=noninteractive
#ENV container docker
#
## 시스템 패키지 업데이트 및 필수 패키지 설치
#RUN apt update && apt upgrade -y && \
#    apt install -y systemd systemd-sysv vim apache2 libapache2-mod-shib openssl \
#    wget unzip nano iputils-ping software-properties-common curl && \
#    add-apt-repository universe && \
#    echo "deb [signed-by=/usr/share/keyrings/shibboleth-archive-keyring.asc] http://pkg.switch.ch/switchaai/ubuntu jammy main" | tee /etc/apt/sources.list.d/shibboleth.list && \
#    apt update && \
#    apt install -y libapache2-mod-shib && \
#    systemctl enable apache2 && \
#    systemctl enable shibd
#
## SSL 인증서 생성
#RUN mkdir -p /etc/shibboleth/certs && \
#    openssl req -new -x509 -days 365 -nodes \
#    -out /etc/shibboleth/certs/sp-cert.pem \
#    -keyout /etc/shibboleth/certs/sp-key.pem \
#    -subj "/C=KR/ST=Seoul/L=JungGu/O=Innogrid/OU=Innogrid.com/CN=shibboleth-sp"
#
## Apache 설정 복사
#COPY shibboleth.conf /etc/apache2/sites-available/shibboleth.conf
#
## Shibboleth 설정 파일 복사
#COPY idp-metadata.xml /etc/shibboleth/idp-metadata.xml
#COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
#COPY attribute-map.xml /etc/shibboleth/attribute-map.xml
#COPY attribute-policy.xml /etc/shibboleth/attribute-policy.xml
#
### 컨테이너 내에서 systemd 실행을 위한 설정
##STOPSIGNAL SIGRTMIN+3
#
## Apache 및 Shibboleth 서비스 적용 및 시작
#RUN a2ensite shibboleth && \
#    echo "ServerName shibboleth-sp" >> /etc/apache2/apache2.conf && \
#    a2enmod ssl headers shib && \
#    service apache2 restart && \
#    systemctl enable shibd && systemctl start shibd
#
## 포트 노출
#EXPOSE 80 443
#
### systemd를 컨테이너의 기본 프로세스로 실행
##CMD ["/lib/systemd/systemd"]
# Ubuntu 22.04 (Jammy Jellyfish) 기반 이미지 사용
#
#FROM ubuntu:22.04
#
## 환경 변수 설정
#ENV DEBIAN_FRONTEND=noninteractive
#ENV container docker
#
## 시스템 패키지 업데이트 및 필수 패키지 설치
#RUN apt update && apt upgrade -y && \
#    apt install -y vim apache2 libapache2-mod-shib openssl \
#    wget unzip nano iputils-ping software-properties-common curl && \
#    add-apt-repository universe && \
#    echo "deb [signed-by=/usr/share/keyrings/shibboleth-archive-keyring.asc] http://pkg.switch.ch/switchaai/ubuntu jammy main" | tee /etc/apt/sources.list.d/shibboleth.list && \
#    apt update && \
#    apt install -y libapache2-mod-shib
#
## SSL 인증서 생성
#RUN mkdir -p /etc/shibboleth/certs && \
#    openssl req -new -x509 -days 365 -nodes \
#    -out /etc/shibboleth/certs/sp-cert.pem \
#    -keyout /etc/shibboleth/certs/sp-key.pem \
#    -subj "/C=KR/ST=Seoul/L=JungGu/O=Innogrid/OU=Innogrid.com/CN=shibboleth-sp"
#
## Apache 설정 복사
#COPY shibboleth.conf /etc/apache2/sites-available/shibboleth.conf
#
## Shibboleth 설정 파일 복사
#COPY idp-metadata.xml /etc/shibboleth/idp-metadata.xml
#COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
#COPY attribute-map.xml /etc/shibboleth/attribute-map.xml
#COPY attribute-policy.xml /etc/shibboleth/attribute-policy.xml
#
## Apache 및 Shibboleth 서비스 설정 적용
#RUN a2ensite shibboleth && \
#    echo "ServerName shibboleth-sp" >> /etc/apache2/apache2.conf && \
#    a2enmod ssl headers shib
#
## Shibboleth Listener 소켓 디렉토리 생성 및 권한 설정
#RUN mkdir -p /var/run/shibboleth && \
#    chmod 750 /var/run/shibboleth && \
#    chown root:root /var/run/shibboleth
#
## 포트 노출
#EXPOSE 80 443
#
## 컨테이너 실행 시 Apache 및 Shibboleth 시작
#CMD /usr/sbin/apachectl -D FOREGROUND & /usr/sbin/shibd -f & tail -f /dev/null
#
## Ubuntu 22.04 기반 Shibboleth SP 컨테이너
#FROM ubuntu:22.04
#
## 환경 변수 설정
#ENV DEBIAN_FRONTEND=noninteractive
#ENV container docker
#
## 시스템 패키지 업데이트 및 필수 패키지 설치
#RUN apt update && apt upgrade -y && \
#    apt install -y vim apache2 libapache2-mod-shib openssl \
#    wget unzip nano iputils-ping software-properties-common curl libxml2-utils && \
#    add-apt-repository universe && \
#    echo "deb [signed-by=/usr/share/keyrings/shibboleth-archive-keyring.asc] http://pkg.switch.ch/switchaai/ubuntu jammy main" | tee /etc/apt/sources.list.d/shibboleth.list && \
#    apt update && \
#    apt install -y libapache2-mod-shib
#
## SSL 인증서 생성
#RUN mkdir -p /etc/shibboleth/certs && \
#    openssl req -new -x509 -days 365 -nodes \
#    -out /etc/shibboleth/certs/sp-cert.pem \
#    -keyout /etc/shibboleth/certs/sp-key.pem \
#    -subj "/C=KR/ST=Seoul/L=JungGu/O=Innogrid/OU=Innogrid.com/CN=shibboleth-sp"
#
## Apache 및 Shibboleth 설정 파일 복사
#COPY shibboleth.conf /etc/apache2/sites-available/shibboleth.conf
#COPY idp-metadata.xml /etc/shibboleth/idp-metadata.xml
#COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
#COPY attribute-map.xml /etc/shibboleth/attribute-map.xml
#COPY attribute-policy.xml /etc/shibboleth/attribute-policy.xml
#
## Apache 및 Shibboleth 서비스 설정 적용
#RUN a2ensite shibboleth && \
#    echo "ServerName shibboleth-sp" >> /etc/apache2/apache2.conf && \
#    a2enmod ssl headers shib
#
## Shibboleth Listener 소켓 디렉토리 생성 및 권한 설정
#RUN mkdir -p /var/run/shibboleth && \
#    chmod 750 /var/run/shibboleth && \
#    chown root:root /var/run/shibboleth
#
## 실행 스크립트 복사 및 실행 권한 부여
#COPY entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#
## 포트 노출
#EXPOSE 80 443
#
## 컨테이너 실행 시 Apache 및 Shibboleth 시작
#ENTRYPOINT ["/entrypoint.sh"]

## ✅ Ubuntu 22.04 기반 최신 이미지 사용
#FROM ubuntu:22.04
#
## ✅ 비대화 모드 설정
#ENV DEBIAN_FRONTEND=noninteractive
#
## ✅ 시스템 패키지 업데이트 및 필수 패키지 설치 (최적화)
#RUN sed -i 's|http://archive.ubuntu.com|http://mirror.kakao.com|g' /etc/apt/sources.list && \
#    sed -i 's|http://security.ubuntu.com|http://mirror.kakao.com|g' /etc/apt/sources.list && \
#    apt update && \
#    apt install -y --no-install-recommends \
#        vim apache2 openssl wget unzip nano iputils-ping \
#        software-properties-common curl libxml2-utils && \
#    rm -rf /var/lib/apt/lists/*
#
## ✅ Shibboleth GPG 키 추가
#RUN wget -O /usr/share/keyrings/shibboleth-archive-keyring.asc \
#    https://pkg.switch.ch/switchaai/ubuntu/shibboleth-archive-keyring.asc
#
## ✅ Shibboleth 저장소 추가
#RUN echo "deb [arch=amd64] http://pkg.switch.ch/switchaai/ubuntu jammy main" \
#    | tee /etc/apt/sources.list.d/shibboleth.list && \
#    apt update && apt install -y libapache2-mod-shib && \
#    rm -rf /var/lib/apt/lists/*
#
## ✅ SSL 인증서 생성
#RUN mkdir -p /etc/shibboleth/certs && \
#    openssl req -new -x509 -days 365 -nodes \
#        -out /etc/shibboleth/certs/sp-cert.pem \
#        -keyout /etc/shibboleth/certs/sp-key.pem \
#        -subj "/C=KR/ST=Seoul/L=JungGu/O=Innogrid/OU=Innogrid.com/CN=shibboleth-sp"
#
## ✅ Apache 및 Shibboleth 설정 파일 복사
#COPY shibboleth.conf /etc/apache2/sites-available/shibboleth.conf
#COPY idp-metadata.xml /etc/shibboleth/idp-metadata.xml
#COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
#COPY attribute-map.xml /etc/shibboleth/attribute-map.xml
#COPY attribute-policy.xml /etc/shibboleth/attribute-policy.xml
#
## ✅ Apache 및 Shibboleth 서비스 설정 적용
#RUN a2ensite shibboleth && \
#    echo "ServerName shibboleth-sp" >> /etc/apache2/apache2.conf && \
#    a2enmod ssl headers shib
#
## ✅ Shibboleth Listener 소켓 디렉토리 생성 및 권한 설정
#RUN mkdir -p /var/run/shibboleth && \
#    chmod 750 /var/run/shibboleth && \
#    chown root:root /var/run/shibboleth
#
## ✅ 실행 스크립트 복사 및 실행 권한 부여
#COPY entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#
## ✅ 포트 노출
#EXPOSE 80 443
#
## ✅ 컨테이너 실행 시 Apache 및 Shibboleth 시작
#CMD ["/entrypoint.sh"]

## Ubuntu 22.04 기반 이미지
##FROM ubuntu:22.04
#FROM ubuntu:24.04
#
## 환경 변수 설정
#ENV DEBIAN_FRONTEND=noninteractive
#ENV container docker
#
## 시스템 패키지 업데이트 및 필수 패키지 설치
#RUN apt update && apt upgrade -y && \
#    apt install -y vim apache2 openssl wget unzip nano iputils-ping \
#    software-properties-common curl libxml2-utils && \
#    add-apt-repository universe
#
## Shibboleth GPG 키 추가
## RUN wget -O /usr/share/keyrings/shibboleth-archive-keyring.asc https://pkg.switch.ch/switchaai/ubuntu/shibboleth-archive-keyring.asc
#
## Shibboleth 저장소 추가
#RUN echo "deb [arch=amd64] http://pkg.switch.ch/switchaai/ubuntu jammy main" | tee /etc/apt/sources.list.d/shibboleth.list
#
## 패키지 목록 업데이트 및 Shibboleth 설치
#RUN apt clean && rm -rf /var/lib/apt/lists/* && apt update && apt install -y libapache2-mod-shib
#
## SSL 인증서 생성
#RUN mkdir -p /etc/shibboleth/certs && \
#    openssl req -new -x509 -days 365 -nodes \
#    -out /etc/shibboleth/certs/sp-cert.pem \
#    -keyout /etc/shibboleth/certs/sp-key.pem \
#    -subj "/C=KR/ST=Seoul/L=JungGu/O=Innogrid/OU=Innogrid.com/CN=shibboleth-sp"
#
## Apache 및 Shibboleth 설정 파일 복사
#COPY shibboleth.conf /etc/apache2/sites-available/shibboleth.conf
#COPY idp-metadata.xml /etc/shibboleth/idp-metadata.xml
#COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
#COPY attribute-map.xml /etc/shibboleth/attribute-map.xml
#COPY attribute-policy.xml /etc/shibboleth/attribute-policy.xml
#
## Apache 및 Shibboleth 서비스 설정 적용
#RUN a2ensite shibboleth && \
#    echo "ServerName shibboleth-sp" >> /etc/apache2/apache2.conf && \
#    a2enmod ssl headers shib
#
## Shibboleth Listener 소켓 디렉토리 생성 및 권한 설정
#RUN mkdir -p /var/run/shibboleth && \
#    chmod 750 /var/run/shibboleth && \
#    chown root:root /var/run/shibboleth
#
## 실행 스크립트 복사 및 실행 권한 부여
#COPY entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#
## 포트 노출
#EXPOSE 80 443
#
## 컨테이너 실행 시 Apache 및 Shibboleth 시작
#ENTRYPOINT ["/entrypoint.sh"]

FROM ubuntu:24.04

# 환경 변수 설정
ENV DEBIAN_FRONTEND=noninteractive
ENV container docker

# 시스템 패키지 업데이트 및 필수 패키지 설치
RUN apt update && apt upgrade -y && \
    apt install -y vim apache2 openssl wget unzip nano iputils-ping \
    software-properties-common curl libxml2-utils gnupg && \
    add-apt-repository universe

# Shibboleth 저장소 추가 (Ubuntu 24.04 - Noble 지원)
RUN echo "deb [signed-by=/usr/share/keyrings/shibboleth-archive-keyring.asc] http://pkg.switch.ch/switchaai/ubuntu noble main" | tee /etc/apt/sources.list.d/shibboleth.list && \
    apt update

# Shibboleth 패키지 설치
# RUN apt install -y libapache2-mod-shib2 shibboleth-sp2-common shibboleth-sp2-utils
#RUN apt install -y libapache2-mod-shib
RUN apt install -y libapache2-mod-shib

# SSL 인증서 생성
#RUN mkdir -p /etc/shibboleth/certs && \
#    openssl req -new -x509 -days 365 -nodes \
#    -out /etc/shibboleth/certs/sp-cert.pem \
#    -keyout /etc/shibboleth/certs/sp-key.pem \
#    -subj "/C=KR/ST=Seoul/L=JungGu/O=Innogrid/OU=Innogrid.com/CN=shibboleth-sp"
RUN mkdir -p /etc/shibboleth/certs && \
    openssl req -new -x509 -days 365 -nodes \
    -out /etc/shibboleth/certs/sp-cert.pem \
    -keyout /etc/shibboleth/certs/sp-key.pem \
    -subj "/C=KR/ST=Seoul/L=JungGu/O=Innogrid/OU=Innogrid.com/CN=shibboleth-sp"

# Apache 및 Shibboleth 설정 파일 복사
COPY shibboleth.conf /etc/apache2/sites-available/shibboleth.conf
COPY idp-metadata.xml /etc/shibboleth/idp-metadata.xml
COPY shibboleth2.xml /etc/shibboleth/shibboleth2.xml
COPY attribute-map.xml /etc/shibboleth/attribute-map.xml
COPY attribute-policy.xml /etc/shibboleth/attribute-policy.xml

# Apache 및 Shibboleth 서비스 설정 적용
RUN if [ -f /etc/apache2/sites-available/shibboleth.conf ]; then a2ensite shibboleth; fi && \
    echo "ServerName shibboleth-sp" >> /etc/apache2/apache2.conf && \
    a2enmod ssl headers shib

# Shibboleth Listener 소켓 디렉토리 생성 및 권한 설정
RUN mkdir -p /var/run/shibboleth && \
    chown _shibd:_shibd /var/run/shibboleth && \
    chmod 755 /var/run/shibboleth
#    chmod 755 /var/run/shibboleth # apache2에서 접근하려면 750이 아니라 755

# 실행 스크립트 복사 및 실행 권한 부여
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 포트 노출
EXPOSE 80 443

# 컨테이너 실행 시 Apache 및 Shibboleth 시작
ENTRYPOINT ["/entrypoint.sh"]