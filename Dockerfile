FROM alpine:3.7

RUN apk add --no-cache curl gettext libintl

COPY scripts  /scripts

RUN find /scripts -type f -iname "*.sh" -exec chmod +x {} \;