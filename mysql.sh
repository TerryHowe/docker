PERSISTENT_DIRECTORY="$HOME/persistent/mysql"
mkdir -p $PERSISTENT_DIRECTORY
docker run --name mysql -h mysql -v ${PERSISTENT_DIRECTORY}:/var/lib/mysql \
    -v ${PERSISTENT_DIRECTORY}/my.cnf:/etc/mysql/conf.d/mysql.cnf \
    -p 127.0.0.1:3306:3306 -e "MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}" -d --restart always mysql:5.7 --character-set-server=utf8

