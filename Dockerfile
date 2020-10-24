FROM alpine:latest
MAINTAINER Rolf K. 

RUN apk add --no-cache \
    ca-certificates \
    python3 \
    wget \
    bash \
 && python3 -m ensurepip \
 && pip3 install greg stagger apprise

COPY crontab /var/spool/cron/crontabs/root
COPY greg.conf /usr/lib/python3.8/site-packages/greg/data/
COPY wget-greg.sh /root

USER root

ENTRYPOINT []

CMD ["crond", "-l", "0", "-f"]

