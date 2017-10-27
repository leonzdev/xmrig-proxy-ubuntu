from ubuntu:xenial
COPY run.sh /
COPY xmrig-proxy /app
EXPOSE 10010
RUN adduser --system --disabled-password --home /ubuntu ubuntu && \
    apt-get update -y && \
    apt-get install -y uuid libuv1 && \
    chmod a+x /app && \
    chmod a+x /run.sh
USER ubuntu 
ENTRYPOINT ["/run.sh"]

