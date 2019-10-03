FROM nginx:1.17-alpine
ENV TZ Europe/Vienna

RUN rm -rfv /etc/nginx/conf.d
RUN mkdir /etc/nginx/conf.d
RUN mkdir /etc/nginx/ssl
RUN mkdir /etc/nginx/dhparams

COPY dhparams/ffdhe2048.txt /etc/nginx/dhparams/dhparams.pem

# Timezone
RUN apk add --no-cache tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# Logrotate
RUN apk add --no-cache coreutils
RUN mkdir /scripts
COPY scripts/logrotate.sh /scripts/logrotate.sh
RUN chmod +x /scripts/logrotate.sh
