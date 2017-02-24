import os
import threading
from kafka import KafkaConsumer
from cassandra.cluster import Cluster

class Configuration:
    def __init__(self):
        self.sink_thread_count = int(os.getenv('SINK_THREAD_COUNT', '2'))
        cassandra_address = os.getenv('CASSANDRA_ADDRESS', 'node.cassandra.l4lb.thisdcos.directory:9042')
        self.cassandra_server, self.cassandra_port = cassandra_address.split(':')
        self.cassandra_keyspace = os.getenv('CASSANDRA_KEYSPACE', 'sink_keyspace')
        self.cassandra_sink = os.getenv('CASSANDRA_SINK', 'sink')
        self.kafka_address = os.getenv('KAFKA_ADDRESS', "broker.kafka.l4lb.thisdcos.directory:9092")
        self.kafka_source = os.getenv('KAFKA_SOURCE', 'source')

    def __del__(self):
        pass


config = Configuration()


def kafka_consumer():
    return KafkaConsumer(config.kafka_source, bootstrap_servers=config.kafka_address)


def cassandra_session():
    cluster = Cluster([config.cassandra_server], port=config.cassandra_port)
    session = cluster.connect()
    createkeyspace = "CREATE KEYSPACE IF NOT EXISTS " + config.cassandra_keyspace + " WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 3 };"
    session.execute(createkeyspace)
    session = cluster.connect(config.cassandra_sink)
    session.execute("CREATE TABLE IF NOT EXISTS sinkaroni (uid uuid, event text, PRIMARY KEY (uid));")
    return cluster, session


def _worker():
    cluster, session = cassandra_session()
    consumer = kafka_consumer()
    for msg in consumer:
        session.execute("INSERT INTO sinkaroni (uid, event) VALUES (minTimeuuid(" + str(msg.timestamp) + "), '" + str(msg.value) + "');")
    cluster.shutdown()
    return


if __name__ == "__main__":
    threads = []
    for i in range(config.sink_thread_count):
        t = threading.Thread(target=_worker)
        threads.append(t)
        t.daemon = True
        t.start()
    for t in threads:
        t.join()
