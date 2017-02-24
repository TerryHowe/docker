# pycassandra
An example dockerized Cassandra application.  This is not meant to be a starter application, it is a very simple sample Cassandra application.  It is assumed that you can already deploy an application.

## Build and push

To build and push the application use variable like this:
```
REGISTRY_URL=registry-ncw.prod-admin.cloud.twc.net
TEAMNAME=terry
VERSION=1.0

docker login $REGISTRY_URL
docker build -t ${VERSION} .
docker tag ${VERSION} ${REGISTRY_URL}/${TEAMNAME}/pycassandra:${VERSION}
docker push ${REGISTRY_URL}/${TEAMNAME}/pycassandra:${VERSION}
```

## Deploy

Here is an example of how you would deploy, use values appropriate for your environment:
```
REGISTRY_URL=registry-ncw.prod-admin.cloud.twc.net
TEAMNAME=terry
VERSION=1.0
VIP=71.74.187.9
CREDENTIAL_FILE=/etc/creds/terry/123.gz

sed -e "s/\${VERSION}/${VERSION}/" \
    -e "s/\${TEAMNAME}/${TEAMNAME}/" \
    -e "s/\${REGISTRY_URL}/${REGISTRY_URL}/" \
    -e "s/\${VIP}/${VIP}/" \
    -e "s,\${CREDENTIAL_FILE},${CREDENTIAL_FILE}," \
    deploy.json.sample >deploy.json

dcos marathon app add  ./deploy.json
```
