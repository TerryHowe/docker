import time
from pykafka import KafkaClient

hosts = [
    "broker-0.proto-shared-kafka.mesos:1027",
    "broker-1.proto-shared-kafka.mesos:1027",
    "broker-2.proto-shared-kafka.mesos:1027"
]
hoststr = ','.join(hosts)
f = open('./mylog','w')
f.write('-------------------------------\n')
f.write(hoststr)
f.write('\n')
f.write('-------------------------------\n')
client = KafkaClient(hosts=hoststr)
f.write('-------------------------------\n')
f.write(str(client.topics))
f.write('\n')
f.write('-------------------------------\n')
time.sleep(50000)

