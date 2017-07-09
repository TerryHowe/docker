PERSISTENT_DIRECTORY="$HOME/persistent/rabbitmq"
mkdir -p $PERSISTENT_DIRECTORY
docker run --name rabbitmq -h rabbitmq -v ${PERSISTENT_DIRECTORY}:/var/lib/rabbitmq -d --restart always rabbitmq:3.6

