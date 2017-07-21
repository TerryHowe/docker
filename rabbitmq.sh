PERSISTENT_DIRECTORY="$HOME/persistent/rabbitmq"
mkdir -p $PERSISTENT_DIRECTORY
docker run --name rabbitmq -h rabbitmq -v ${PERSISTENT_DIRECTORY}:/var/lib/rabbitmq -p 127.0.0.1:5672:5672 -p 127.0.0.1:15672:15672 -d --restart always rabbitmq:3.6-management
