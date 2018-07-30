FROM openjdk:8u171-jre
MAINTAINER Alpha Hinex <AlphaHinex@gmail.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales fonts-wqy-zenhei

RUN sed -i -e 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=zh_CN.UTF-8

ENV LANG zh_CN.UTF-8

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

EXPOSE 8080
