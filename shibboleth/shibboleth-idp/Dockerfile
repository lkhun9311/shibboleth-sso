FROM unicon/shibboleth-idp:latest

# yum 관련 기본 설정 수정
RUN sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo && \
    yum clean all && yum makecache && \
    yum -y update && \
    yum install -y vim openssl wget unzip nano iputils curl cronie python3

# MariaDB 설치 경로 생성
RUN mkdir -p /opt/shibboleth-idp/edit-webapp/WEB-INF/lib

# custom-login 폴더 경로 생성
RUN mkdir -p /opt/shibboleth-idp/custom-login/classes

# JDBC 및 jBCrypt 라이브러리 다운로드
RUN wget https://downloads.mariadb.com/Connectors/java/connector-java-2.7.4/mariadb-java-client-2.7.4.jar \
         -O /opt/shibboleth-idp/edit-webapp/WEB-INF/lib/mariadb-java-client-2.7.4.jar && \
    wget https://repo1.maven.org/maven2/org/mindrot/jbcrypt/0.4/jbcrypt-0.4.jar \
         -O /opt/shibboleth-idp/edit-webapp/WEB-INF/lib/jbcrypt-0.4.jar

# Shibboleth 설정 파일 복사
COPY ./customized-shibboleth-idp/conf /opt/shibboleth-idp/conf
COPY ./customized-shibboleth-idp/credentials /opt/shibboleth-idp/credentials
COPY ./customized-shibboleth-idp/custom-login /opt/shibboleth-idp/custom-login
COPY ./customized-shibboleth-idp/metadata /opt/shibboleth-idp/metadata
COPY update-validuntil.py /usr/local/bin/update-validuntil.py

# update-validuntil.py 권한 설정
RUN chmod +x /usr/local/bin/update-validuntil.py

# update-validuntil.py cron 등록 및 실행
RUN echo "*/1 * * * * root python3 /usr/local/bin/update-validuntil.py >> /var/log/update-validuntil.log 2>&1" > /etc/cron.d/idp-metadata && \
    chmod 0644 /etc/cron.d/idp-metadata && \
    python3 /usr/local/bin/update-validuntil.py

# JAVA 환경 설정
ENV JAVA_HOME=/opt/zulu8.38.0.13-ca-jdk8.0.212-linux_x64
ENV PATH=${JAVA_HOME}/bin:${PATH}
RUN chmod +x ${JAVA_HOME}/bin/*

# JdbcLoginModule 파일 컴파일 (jbcrypt 포함)
RUN javac -encoding UTF-8 -cp /opt/shibboleth-idp/edit-webapp/WEB-INF/lib/jbcrypt-0.4.jar \
    -d /opt/shibboleth-idp/custom-login/classes \
    /opt/shibboleth-idp/custom-login/src/my/auth/JdbcLoginModule.java && \
    cd /opt/shibboleth-idp/custom-login/classes && \
    jar cf jdbc-loginmodule.jar my/auth/JdbcLoginModule.class

# 빌드된 jar를 lib로 복사
RUN cp /opt/shibboleth-idp/custom-login/classes/jdbc-loginmodule.jar /opt/shibboleth-idp/edit-webapp/WEB-INF/lib/

# 모든 jar를 Jetty ext로 복사
RUN cp /opt/shibboleth-idp/edit-webapp/WEB-INF/lib/*.jar /opt/shib-jetty-base/lib/ext/

# Jetty가 login.config를 인식하도록 설정
RUN echo '-Djava.security.auth.login.config=/opt/shibboleth-idp/conf/login.config' >> /opt/shib-jetty-base/start.ini

# idp.properties 설정
RUN echo 'idp.authn.JAAS.loginConfig=/opt/shibboleth-idp/conf/login.config' >> /opt/shibboleth-idp/conf/idp.properties

# password-authn-flow.xml 복사
RUN mkdir -p /opt/shibboleth-idp/flows/authn/password && \
    cp /opt/shibboleth-identity-provider-3.4.3/system/flows/authn/password-authn-flow.xml \
       /opt/shibboleth-idp/flows/authn/password/password-authn-flow.xml

EXPOSE 4443 8443