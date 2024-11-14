FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]
LABEL maintainer="rafa@gmail.com"
ARG APP_DIR=/app
ARG APP_PORT=8080

RUN apt-get update && apt-get install -y systemctl
RUN apt-get install -y openjdk-11-jdk
RUN apt-get install -y nginx
ONBUILD RUN apt-get install -y git

USER root
COPY conf.sh /usr/local/bin/conf.sh

RUN chmod +x /usr/local/bin/conf.sh
WORKDIR $APP_DIR

VOLUME [ "/data" ]

HEALTHCHECK CMD ping -c 10 ya.ru || exit 1
COPY ./nginx-conf.txt /etc/nginx/sites-available/default
ADD https://github.com/fernandosanchezmunoz/simpleweb-java/raw/master/simpleweb.jar /app/simpleweb.jar
ENV PORT0=$APP_PORT

EXPOSE 80

ENTRYPOINT ["bash", "/usr/local/bin/conf.sh"]
CMD [""]

STOPSIGNAL SIGINT