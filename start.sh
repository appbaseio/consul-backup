#!/bin/sh

sleep 2

/usr/bin/crontab /config/cronjob.txt

WEAVE_IP="$(ifconfig ethwe1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"

echo $WEAVE_IP

exec /bin/consul agent -server -config-dir=/config -data-dir /data -bind $WEAVE_IP $@

(/usr/bin/consulate --api-host $SERVER_HOST --api-port $SERVER_PORT --token=$CONSUL_TOKEN kv restore --file=/data/kv.json) &
(/usr/bin/consulate --api-host $SERVER_HOST --api-port $SERVER_PORT --token=$CONSUL_TOKEN acl restore --file=/data/acl.json) &
