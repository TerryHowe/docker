set -x
docker stop fakes3
docker rm fakes3
PERSISTENT_DIRECTORY="$HOME/persistent/fakes3"
mkdir -p $PERSISTENT_DIRECTORY
docker run --name fakes3 -h fakes3 \
    -v ${PERSISTENT_DIRECTORY}:/fakes3/data:rw \
    -p "4567:4567" \
    -d \
    --restart always \
    elselabsio/fakes3
