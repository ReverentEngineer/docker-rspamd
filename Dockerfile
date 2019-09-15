FROM alpine
RUN apk update && apk add rspamd
RUN echo 'type = "console";' > /etc/rspamd/override.d/logging.inc \
	&& echo 'bind_socket = "*:11334";' > /etc/rspamd/override.d/worker-controller.inc \
	&& echo 'pidfile = false;' > /etc/rspamd/override.d/options.inc
VOLUME	[ "/var/lib/rspamd" ]
CMD	[ "/usr/bin/rspamd", "-f", "-u", "rspamd", "-g", "rspamd" ]
EXPOSE	11333 11334