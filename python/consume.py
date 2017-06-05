#!/usr/bin/env python
from __future__ import print_function

import os
import sys

from kafka import KafkaConsumer

KAFKA_TOPIC = os.getenv("EVENTADOR_KAFKA_TOPIC", "brewery")
KAFKA_BROKERS = os.getenv("EVENTADOR_BOOTSTRAP_SERVERS", "localhost:9092")

consumer = KafkaConsumer(KAFKA_TOPIC, bootstrap_servers=KAFKA_BROKERS)

print("connected to {} topic {}".format(KAFKA_BROKERS, KAFKA_TOPIC))

try:
    for msg in consumer:
        print(msg)
except KeyboardInterrupt:
    sys.exit()
