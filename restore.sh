/usr/bin/aws s3 cp s3://$S3_BUCKET_NAME/data /data --recursive
/usr/bin/consulate --api-host $SERVER_HOST --api-port $SERVER_PORT --token=$CONSUL_TOKEN kv restore --file=/data/kv.json
/usr/bin/consulate --api-host $SERVER_HOST --api-port $SERVER_PORT --token=$CONSUL_TOKEN acl restore --file=/data/acl.json
