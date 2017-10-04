from __future__ import print_function  # python 2/3 compatibility

import os

from kafka import KafkaProducer

KAFKA_BROKERS = os.getenv('EVENTADOR_PLAINTEXT_ENDPOINT')
KAFKA_TOPIC = os.getenv('EVENTADOR_KAFKA_TOPIC')

producer = KafkaProducer(bootstrap_servers=KAFKA_BROKERS)

# Must send bytes
messages = [b'hello kafka', b'I am sending', b'3 test messages']

# Send the messages
for m in messages:
    producer.send(KAFKA_TOPIC, m)
producer.flush()
