import json
import os
import random
import time
import sys
from kafka import KafkaProducer

EVENTADOR_KAFKA_TOPIC = os.getenv("EVENTADOR_KAFKA_TOPIC", "brewery")
EVENTADOR_BOOTSTRAP_SERVERS = os.getenv("EVENTADOR_BOOTSTRAP_SERVERS", "localhost:9092")

print "connected to {} topic {}".format(EVENTADOR_BOOTSTRAP_SERVERS, EVENTADOR_KAFKA_TOPIC)


def get_sensor():
    """ return a random temperature between x and y """
    return random.randrange(30, 90)


def sendto_eventador(payload):
    """ send off to eventador Kafka """
    try:
        producer = KafkaProducer(value_serializer=lambda v: json.dumps(v).encode('utf-8'),
                                 bootstrap_servers=EVENTADOR_BOOTSTRAP_SERVERS)
        producer.send(EVENTADOR_KAFKA_TOPIC, payload)
        producer.flush()
    except:
        "print unable to produce to {} topic {}".format(EVENTADOR_BOOTSTRAP_SERVERS, EVENTADOR_KAFKA_TOPIC)

payload = {}
while True:
    try:
        # run forever
        sensors = ["MashTun1", "MashTun2"]
        for sensor in sensors:
            payload = {"sensor": sensor, "temp": get_sensor()}
            sendto_eventador(payload)
            print payload
            sendto_eventador(payload)
        time.sleep(3)
    except KeyboardInterrupt:
        sys.exit()
