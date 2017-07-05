PERSISTENT_DIRECTORY="$HOME/persistent/redis"
mkdir -f $PERSISTENT_DIRECTORY
docker run --name terry-redis -v ${PERSISTENT_DIRECTORY}:/data -d --restart always redis:3.2

