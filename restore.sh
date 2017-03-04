/usr/bin/aws s3 cp s3://consul-autopilot-backups/data /data --recursive
/usr/bin/consulate --api-host $SERVER_HOST --api-port $SERVER_PORT --token=$CONSUL_TOKEN kv restore --file=/data/kv.json
/usr/bin/consulate --api-host $SERVER_HOST --api-port $SERVER_PORT --token=$CONSUL_TOKEN acl restore --file=/data/acl.json
