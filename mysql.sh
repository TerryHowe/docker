#docker stop mysql
#docker rm mysql
PERSISTENT_DIRECTORY="/private/mysql"
mkdir -p $PERSISTENT_DIRECTORY
cat >${PERSISTENT_DIRECTORY}/my.cnf <<!
[mysqld]
skip-host-cache
skip-name-resolve
sql_mode = NO_ENGINE_SUBSTITUTION
explicit_defaults_for_timestamp = 1
!
docker run --name mysql -h mysql \
    -v ${PERSISTENT_DIRECTORY}:/var/lib/mysql \
    -v ${PERSISTENT_DIRECTORY}/my.cnf:/etc/mysql/conf.d/docker.cnf \
    -e "MYSQL_ALLOW_EMPTY_PASSWORD=yes" \
    -p 127.0.0.1:3306:3306 \
    -d \
    --restart always \
    mysql:5.7 \
    --explicit_defaults_for_timestamp=1 \
    --disable-partition-engine-check \
    --character-set-server=utf8

