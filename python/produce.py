#!/usr/bin/env python
import json
import os
import random
import time
import sys
from kafka import KafkaProducer

KAFKA_TOPIC = os.getenv("KAFKA_TOPIC", "brewery")
KAFKA_BROKERS = os.getenv("KAFKA_BROKERS", "localhost:9092")

# Setup producer connection
producer = KafkaProducer(value_serializer=lambda v: json.dumps(v).encode('utf-8'),
                         bootstrap_servers=KAFKA_BROKERS)

print "connected to {} topic {}".format(KAFKA_BROKERS, KAFKA_TOPIC)


def get_sensor():
    """Return a random temperature between 30 and 90."""
    return random.randrange(30, 90)


def sendto_eventador(payload):
    """Add a message to the produce buffer asynchronously to be sent to Eventador."""
    try:
        producer.send(KAFKA_TOPIC, payload)
    except:
        "Print unable to produce to {} topic {}".format(KAFKA_BROKERS, KAFKA_TOPIC)

payload = {}
while True:
    try:
        # run forever
        sensors = ["MashTun1", "MashTun2"]

        for sensor in sensors:
            payload = {"sensor": sensor, "temp": get_sensor()}
            sendto_eventador(payload)
            print payload

        # Flush the produce buffer and send to kafka
        producer.flush()
        time.sleep(3)

    except KeyboardInterrupt:
        sys.exit()
