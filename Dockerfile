FROM alpine:3.16

RUN apk update && \
    apk add --no-cache bash curl nginx nginx-mod-stream certbot openssl supervisor

COPY ./code/* /
COPY ./configs/nginx* /configs/
COPY ./configs/supervisord.conf /etc/supervisord.conf
ADD https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem.txt /lets-encrypt-x3-cross-signed.pem

RUN chmod +x /*.sh /*.py && \
        mkdir -p /var/run/nginx/ && \
        mkdir -p /var/letsencrypt \

EXPOSE 80
EXPOSE 443

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]

