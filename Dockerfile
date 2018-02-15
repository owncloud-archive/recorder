FROM owncloud/ubuntu:latest

LABEL maintainer="ownCloud DevOps <devops@owncloud.com>" \
  org.label-schema.name="ownCloud CI recorder" \
  org.label-schema.vendor="ownCloud GmbH" \
  org.label-schema.schema-version="1.0"

RUN apt-get update && \
    apt-get install python-pip -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    pip install --no-cache-dir https://github.com/patrickjahns/vnc2flv/archive/0.1.0.tar.gz && \
    wget -q -O /usr/local/bin/wfi https://github.com/maxcnunes/waitforit/releases/download/v2.2.0/waitforit-linux_amd64 && \
    chmod +x /usr/local/bin/wfi

ADD rootfs /
STOPSIGNAL SIGINT
ENTRYPOINT ["/usr/sbin/plugin.sh"]