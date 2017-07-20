from __future__ import print_function  # python 2/3 compatibility

import sys # used to exit
from kafka import KafkaConsumer

KAFKA_TOPIC = 'demo'
KAFKA_BROKERS= '<value_from_plain_text_endpoint>'

consumer = KafkaConsumer(KAFKA_TOPIC, bootstrap_servers=KAFKA_BROKERS, 
                         auto_offset_reset='earliest')

try:
    for message in consumer:
        print(message.value)
except KeyboardInterrupt:
    sys.exit()
