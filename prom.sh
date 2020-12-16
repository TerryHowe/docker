docker run --name prometheus -h prometheus -v ${PERSISTENT_DIRECTORY}:/data -p 127.0.0.1:9090:9090 -d --restart always prom/prometheus
