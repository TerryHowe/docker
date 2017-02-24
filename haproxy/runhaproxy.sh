#!/bin/bash -xe
echo "${HAPROXY_APPLICATION_CFG}" >/usr/local/etc/haproxy/application.cfg
if [ -n "${HAPROXY_APPLICATION_PEM}" ]
then
  echo "${HAPROXY_APPLICATION_PEM}" >/usr/local/etc/haproxy/application.pem
  chmod 600 /usr/local/etc/haproxy/application.pem
  echo "==============================================="
  cat /usr/local/etc/haproxy/application.pem
fi
echo "==============================================="
cat /usr/local/etc/haproxy/application.cfg
echo "==============================================="
haproxy -f /usr/local/etc/haproxy/haproxy.cfg -f /usr/local/etc/haproxy/application.cfg
echo 'sleeping...'
sleep 1200
