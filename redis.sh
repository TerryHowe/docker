PERSISTENT_DIRECTORY="$HOME/persistent/redis"
mkdir -p $PERSISTENT_DIRECTORY
docker run --name redis -h redis -v ${PERSISTENT_DIRECTORY}:/data -p 127.0.0.1:6379:6379 -d --restart always redis:3.2

