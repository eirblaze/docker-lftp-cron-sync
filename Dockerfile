FROM alpine:3.8

LABEL maintainer="Anton Lebedev <mailbox@lebster.me>"

RUN apk add --no-cache \
  bash \
  curl \
  lftp \
  openssh \
  libressl \
  ca-certificates \
  ; \
  update-ca-certificates;

COPY mirror.sh /

RUN chmod +x /mirror.sh

# Add crontab file in the cron directory
COPY crontab /crontab

# Apply cron job
RUN crontab /crontab

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

# COPY ./cert.pem /root/cert.pem
COPY ./lftp-conf /root/lftp-conf
COPY ./exclude-glob /root/exclude-glob

ENTRYPOINT ["/entrypoint.sh"]

CMD ["crond", "-f", "-L -"]
