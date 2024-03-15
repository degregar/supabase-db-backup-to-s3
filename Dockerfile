FROM alpine:3.18.2

RUN apk add --no-cache curl git bash postgresql-client python3 py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install awscli

COPY entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
