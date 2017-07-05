PERSISTENT_DIRECTORY="$HOME/persistent/redis"
mkdir -p $PERSISTENT_DIRECTORY
docker run --name redis -v ${PERSISTENT_DIRECTORY}:/data -d --restart always redis:3.2

