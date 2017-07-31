PERSISTENT_DIRECTORY="$HOME/persistent/postgres"
mkdir -p $PERSISTENT_DIRECTORY
docker run --name postgres -h postgres -v ${PERSISTENT_DIRECTORY}:/var/lib/postgresql/data  -p 127.0.0.1:5432:5432 -e "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" -d --restart always postgres:9.6
