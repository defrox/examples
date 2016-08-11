import json
from kafka import KafkaProducer

EVENTADOR_KAFKA_TOPIC = "brewery"  # any topic name, will autocreate if needed
EVENTADOR_BOOTSTRAP_SERVERS = "my bootstrap servers"  # value from deployments tab in UI

payload = {}

# this is the data you want to send in
payload['records'] = [
  {"value": {"sensor": "MashTun1", "temp": 99}},
  {"value": {"sensor": "MashTun2", "temp": 42}}
]

producer = KafkaProducer(value_serializer=lambda v: json.dumps(v).encode('utf-8'),
                         bootstrap_servers=EVENTADOR_BOOTSTRAP_SERVERS)
producer.send(EVENTADOR_KAFKA_TOPIC, json.dumps(payload))
