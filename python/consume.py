import json
from pprint import pprint
from kafka import KafkaConsumer

EVENTADOR_KAFKA_TOPIC = "brewery"  # any topic name, will autocreate if needed
EVENTADOR_BOOTSTRAP_SERVERS = "my bootstrap servers"  # value from deployments tab in UI

consumer = KafkaConsumer(EVENTADOR_KAFKA_TOPIC, bootstrap_servers=EVENTADOR_BOOTSTRAP_SERVERS)

for msg in consumer:
    print msg
