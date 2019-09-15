FROM alpine
RUN apk update && apk add rspamd
RUN echo 'type = "console";' > /etc/rspamd/override.d/logging.inc \
	&& echo 'bind_socket = "*:11334";' > /etc/rspamd/override.d/worker-controller.inc \
	&& echo 'pidfile = false;' > /etc/rspamd/override.d/options.inc
ADD redis.conf /etc/rspamd/local.d/redis.conf
ADD dkim_signing.conf /etc/rspamd/local.d/dkim_signing.conf
VOLUME	[ "/var/lib/rspamd" ]
CMD	[ "/usr/sbin/rspamd", "-f", "-u", "rspamd", "-g", "rspamd" ]
EXPOSE	11333 11334
