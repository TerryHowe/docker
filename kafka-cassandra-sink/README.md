# kafka-cassandra-sink
An example dockerized Python Kafka to Cassandra sink.

## Build and push

To build and push the application use variable like this:
```
REGISTRY_URL=registry-ncw.prod-admin.cloud.twc.net
TEAMNAME=paasteam
VERSION=1.0

docker login $REGISTRY_URL
docker build -t ${REGISTRY_URL}/${TEAMNAME}/kafka-cassandra-sink:${VERSION} .
docker push ${REGISTRY_URL}/${TEAMNAME}/kafka-cassandra-sink:${VERSION}
```

## Deploy

Here is an example of how you would deploy, use values appropriate for your environment:
```
cp deploy.json.sample deploy.json
# edit deploy.json to taste
dcos marathon app add ./deploy.json
```
