FROM alpine
RUN apk update && apk add rspamd rspamd-fuzzy rspamd-proxy
RUN echo 'type = "console";' > /etc/rspamd/override.d/logging.inc \
	&& echo 'bind_socket = "*:11334";' > /etc/rspamd/override.d/worker-controller.inc \
	&& echo 'enabled = false;' > /etc/rspamd/override.d/worker-normal.inc \
	&& echo 'pidfile = false;' > /etc/rspamd/override.d/options.inc \
  && echo -e "upstream \"local\" {\n  self_scan = yes;\n}\nbind_socket = \"0.0.0.0:11332\"; milter = yes;" > /etc/rspamd/override.d/worker-proxy.inc \
  && echo 'servers = "redis";' > /etc/rspamd/local.d/redis.conf \
  && echo -e "path = \"/var/lib/rspamd/dkim/\$domain.\$selector.key\";\nallow_username_mismatch = true;" > /etc/rspamd/local.d/dkim_signing.conf
VOLUME	[ "/var/lib/rspamd" ]
CMD	[ "/usr/sbin/rspamd", "-f", "-u", "rspamd", "-g", "rspamd" ]
EXPOSE 11332 11334 
