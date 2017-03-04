FROM golang:1.8-alpine

RUN apk update

# Set GOPATH
ENV GOPATH /go

# Install consul /bin/consul
# taken from https://hub.docker.com/r/gliderlabs/consul/~/dockerfile/

ENV CONSUL_VERSION 0.6.4
ENV CONSUL_SHA256 abdf0e1856292468e2c9971420d73b805e93888e006c76324ae39416edcf0627

RUN apk --no-cache add curl ca-certificates \
    && curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o /tmp/consul.zip \
    && echo "${CONSUL_SHA256}  /tmp/consul.zip" > /tmp/consul.sha256 \
    && sha256sum -c /tmp/consul.sha256 \
    && cd /bin \
    && unzip /tmp/consul.zip \
    && chmod +x /bin/consul \
    && rm /tmp/consul.zip

# create GO dirs
RUN mkdir -p /go/src

# install go deps
RUN apk --no-cache add git bash openssl

# get consul-backup
RUN go get github.com/kailunshi/consul-backup

# install consul-backup
WORKDIR /go/src/github.com/kailunshi/consul-backup
RUN go get
RUN go install

# get awless
WORKDIR /go/src
RUN go get github.com/wallix/awless

# install awless (/go/bin/awless)
WORKDIR /go/src/github.com/wallix/awless
RUN go get
RUN go install

# files
ADD . /config
RUN mkdir /data && touch /data/backup.json 

VOLUME /data

EXPOSE 8300 8301 8302 8500 8600

# set correct working dir
WORKDIR /config

CMD /config/start.sh
