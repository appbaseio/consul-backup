/usr/bin/consulate --api-host $SERVER_HOST --api-port $SERVER_PORT --token=$CONSUL_TOKEN kv backup --file=/data/kv.json
/usr/bin/consulate --api-host $SERVER_HOST --api-port $SERVER_PORT --token=$CONSUL_TOKEN acl backup --file=/data/acl.json
/usr/bin/aws s3 cp /data s3://$S3_BUCKET_NAME/data --recursive
