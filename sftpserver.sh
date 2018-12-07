set -x
docker stop sftpserver
docker rm sftpserver
PERSISTENT_DIRECTORY="$HOME/persistent/sftpserver"
mkdir -p $PERSISTENT_DIRECTORY
docker run --name sftpserver -h sftpserver \
    -v "${PERSISTENT_DIRECTORY}:/home/test:rw" \
    -p 2222:22 \
    -d \
    --restart always \
    atmoz/sftp test:test:::baml,bridgebank
