#!/bin/sh

sleep 2

/usr/bin/crontab /config/cronjob.txt

WEAVE_IP="$(ifconfig ethwe1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"

echo $WEAVE_IP

exec /bin/consul agent -server -config-dir=/config -data-dir /data -bind $WEAVE_IP $@

(/usr/bin/consulate --api-host=127.0.0.1 --token=fd3cf5eb-6374-4e95-b306-86bb054a182e kv restore --file=/data/backup.json) &
