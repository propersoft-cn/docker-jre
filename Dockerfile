FROM openjdk:8u212-jdk
MAINTAINER Alpha Hinex <AlphaHinex@gmail.com>

RUN apt-get update \
   && DEBIAN_FRONTEND=noninteractive apt-get install -y locales fonts-wqy-zenhei \
   && apt-get -y clean

RUN sed -i -e 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=zh_CN.UTF-8

# Download alpn-boot
# Could get versions info on http://www.eclipse.org/jetty/documentation/current/alpn-chapter.html#alpn-versions
RUN curl -o /usr/lib/alpn-boot-8.1.12.v20180117.jar https://repo.gradle.org/gradle/libs/org/mortbay/jetty/alpn/alpn-boot/8.1.12.v20180117/alpn-boot-8.1.12.v20180117.jar

# Install the Java JCE Policy
# Based on https://github.com/commitd/docker-java-jce/blob/master/Dockerfile
RUN curl -q -L -C - -b "oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-8.zip -O http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \
    && unzip -oj -d /docker-java-home/jre/lib/security /tmp/jce_policy-8.zip \*/\*.jar \
    && rm /tmp/jce_policy-8.zip

ENV LANG zh_CN.UTF-8

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
