PERSISTENT_DIRECTORY="$HOME/persistent/mongo"
mkdir -p $PERSISTENT_DIRECTORY
docker run --name mongo -v ${PERSISTENT_DIRECTORY}:/data/db -d --restart always mongo:3.2

