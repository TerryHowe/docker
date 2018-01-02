docker stop sshable 2>/dev/null
docker rm -f sshable 2>/dev/null
docker rmi -f sshable 2>/dev/null
mkdir -p .ssh
chmod 700 .ssh
ssh-keygen -t rsa -f .ssh/id_rsa -N '' -q </dev/null
docker build --tag sshable .
docker run --name sshable -h sshable  -p 127.0.0.1:3022:22 -d sshable:latest
