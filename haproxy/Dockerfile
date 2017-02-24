FROM haproxy:1.6

RUN apt-get update && apt-get install -y gettext

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY runhaproxy.sh /runhaproxy.sh

CMD [ "/bin/bash", "/runhaproxy.sh" ]
