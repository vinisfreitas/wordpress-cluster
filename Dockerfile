FROM haproxy:2.5

RUN apt update -y && apt install bash ca-certificates rsyslog cron -y
RUN mkdir -p /etc/rsyslog.d/ &&  \
        touch /var/log/haproxy.log &&  \
        ln -sf /dev/stdout /var/log/haproxy.log

ADD ./haproxy_etc/ /etc/

EXPOSE 80 443
# Include our custom entrypoint that will the the job of lifting
# rsyslog alongside haproxy.
ADD ./entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

EXPOSE 80 443

# Set our custom entrypoint as the image's default entrypoint
ENTRYPOINT [ "entrypoint" ]

# Make haproxy use the default configuration file
CMD [ "-f", "/etc/haproxy.cfg" ]