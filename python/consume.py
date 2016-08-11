import json
import time
from pprint import pprint
from kafka import KafkaConsumer

EVENTADOR_KAFKA_TOPIC = "brewery"  # any topic name, will autocreate if needed
EVENTADOR_BOOTSTRAP_SERVERS = "my bootstrap servers"  # value from deployments tab in UI

consumer = KafkaConsumer(bootstrap_servers=EVENTADOR_BOOTSTRAP_SERVERS)
consumer.assign([TopicPartition(EVENTADOR_KAFKA_TOPIC, 2)])

for msg in consumer:
    print msg
