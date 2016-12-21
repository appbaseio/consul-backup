FROM gliderlabs/consul:0.6

ADD . /config

RUN apk update
RUN apk add py-pip
RUN pip install consulate
RUN mkdir /data && touch /data/backup.json 

VOLUME /data

EXPOSE 8300 8301 8302 8500 8600

ENTRYPOINT ["/config/start.sh"]
