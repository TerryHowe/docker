import operator
import random
from datetime import datetime
from flask import Flask, render_template, request, url_for
from cassandra.cluster import Cluster

config = {
    "vip": "node.cassandra.l4lb.thisdcos.directory",
    "port": "9042",
    "keyspace": "exemplar",
}
app = Flask(__name__)
images = ['apple', 'banana', 'cherry']


def cassandra_session():
    cluster = Cluster([config["vip"]], port=config["port"])
    session = cluster.connect()
    createkeyspace = "CREATE KEYSPACE IF NOT EXISTS " + config["keyspace"] + " WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 3 };"
    session.execute(createkeyspace)
    session = cluster.connect(config["keyspace"])
    session.execute("CREATE TABLE IF NOT EXISTS timeseries (insertion_time timestamp, event text, PRIMARY KEY (insertion_time));")
    return cluster, session


@app.route("/")
def index():
    cluster, session = cassandra_session()
    random.seed(datetime.utcnow())
    idx = random.randint(0,(len(images)-1))
    results = "<p><img src='/static/{}s.png'>\n".format(images[idx])
    session.execute("INSERT INTO timeseries (event, insertion_time) VALUES ('" +images[idx] + "', dateof(now()));")
    rows = session.execute("SELECT * FROM timeseries;")
    sortedrows = sorted(rows, key=operator.attrgetter('insertion_time'), reverse=True)
    results += "<p>History<br>\n"
    for row in sortedrows:
        results += "{} <img height='20' src='/static/{}s.png'><br>\n".format(row.insertion_time.strftime("%c %H:%M:%S"), row.event)
    results += "\n"
    session = cluster.shutdown()
    return results

if __name__ == "__main__":
    app.run('0.0.0.0')
