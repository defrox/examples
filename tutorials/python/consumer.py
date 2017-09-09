from __future__ import print_function  # python 2/3 compatibility

import os
import sys # used to exit
from kafka import KafkaConsumer

KAFKA_BROKERS = os.getenv('EVENTADOR_PLAINTEXT_ENDPOINT')
KAFKA_TOPIC = os.getenv('EVENTADOR_KAFKA_TOPIC')

consumer = KafkaConsumer(KAFKA_TOPIC, bootstrap_servers=KAFKA_BROKERS,
                         auto_offset_reset='earliest')

try:
    for message in consumer:
        print(message.value)
except KeyboardInterrupt:
    sys.exit()
