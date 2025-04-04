FROM jefferyb/shibboleth-sp

# 작업 디렉토리 설정
#WORKDIR /sp

# init.sh 파일을 컨테이너 내부로 복사
COPY ./init.sh /sp/init.sh

# 실행 권한 부여
RUN chmod +x /sp/init.sh

# init.sh 실행 후 Apache 및 Shibboleth 시작
CMD ["/bin/sh", "-c", "/sp/init.sh && apachectl -D FOREGROUND"]
