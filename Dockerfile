FROM gliderlabs/consul:0.6

# Install dependencies
RUN apk update
RUN apk add py-pip
RUN pip install awscli https://github.com/gmr/consulate/tarball/master

# Data
RUN mkdir /data && touch /data/kv.json && touch /data/acl.json

ADD . /config

VOLUME /data

EXPOSE 8300 8301 8302 8500 8600

WORKDIR /config

ENTRYPOINT ["/config/start.sh"]
