FROM debian:bookworm-slim AS builder
RUN apt-get update && apt-get install -y unzip curl && rm -rf /var/lib/apt/lists/*
WORKDIR /app

FROM httpd:2.4-alpine
LABEL maintainer="admin@example.com"
LABEL version="1.0"

ENV APP_HOME=/usr/local/apache2/htdocs
ENV LOG_DIR=/usr/local/apache2/logs

RUN apk update && apk upgrade && apk add --no-cache bash tzdata
RUN cp /usr/share/zoneinfo/UTC /etc/localtime && echo "UTC" > /etc/timezone

COPY ./public_html/ ${APP_HOME}/

RUN chown -R daemon:daemon ${APP_HOME} && \
    chmod -R 755 ${APP_HOME}

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

CMD ["httpd-foreground"]
