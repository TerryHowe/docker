#docker stop mysql
#docker rm mysql
PERSISTENT_DIRECTORY="$HOME/persistent/mysql"
mkdir -p $PERSISTENT_DIRECTORY
#cat >${PERSISTENT_DIRECTORY}/my.cnf <<!
#explicit_defaults_for_timestamp = 1
#!
# -v ${PERSISTENT_DIRECTORY}/my.cnf:/etc/mysql/conf.d/mysql.cnf \
docker run --name mysql -h mysql \
    -v ${PERSISTENT_DIRECTORY}:/var/lib/mysql \
    -e "MYSQL_ALLOW_EMPTY_PASSWORD=yes" \
    -p 127.0.0.1:3306:3306 \
    -d \
    --restart always \
    mysql:5.7 \
    --explicit_defaults_for_timestamp=1 \
    --disable-partition-engine-check \
    --character-set-server=utf8

