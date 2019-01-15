FROM alpine:3.7

## Add the wait script to the image
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.2.1/wait /wait
RUN ["chmod", "+x", "/wait"]

RUN apk add --no-cache curl gettext libintl

COPY weighted_toggle.template.json add-toggles.sh /
COPY toggle.template.json /
RUN chmod +x /add-toggles.sh

CMD "/wait" && "/add-toggles.sh"
