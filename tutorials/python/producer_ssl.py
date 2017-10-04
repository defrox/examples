from __future__ import print_function  # python 2/3 compatibility

import os
import random
import tempfile
import time

from kafka import KafkaProducer


# Config variables
KAFKA_BROKERS = os.getenv('EVENTADOR_SSL_ENDPOINT')
KAFKA_TOPIC = os.getenv('EVENTADOR_KAFKA_TOPIC')
CA_CERT = os.getenv('EVENTADOR_KAFKA_CA_CERT')
CLIENT_CERT = os.getenv('EVENTADOR_KAFKA_CLIENT_CERT')
CLIENT_KEY = os.getenv('EVENTADOR_KAFKA_CLIENT_KEY')

# Python driver requires SSL connection data stored in physical files
SSL_CA_TEMP = tempfile.NamedTemporaryFile(mode='w+')
SSL_CLIENT_TEMP = tempfile.NamedTemporaryFile(mode='w+')
SSL_KEY_TEMP = tempfile.NamedTemporaryFile(mode='w+')


def create_temp_ssl_files():
    """Create credential files from env variable"""
    SSL_CA_TEMP.write(CA_CERT)
    SSL_CA_TEMP.flush()
    print("Created temp ssl ca file: {}".format(SSL_CA_TEMP.name))

    SSL_CLIENT_TEMP.write(CLIENT_CERT)
    SSL_CLIENT_TEMP.flush()
    print("Created temp ssl client file: {}".format(SSL_CLIENT_TEMP.name))

    SSL_KEY_TEMP.write(CLIENT_KEY)
    SSL_KEY_TEMP.flush()

    print("Created temp ssl key file: {}".format(SSL_KEY_TEMP.name))


def publish_message(message):
    try:
        producer.send(KAFKA_TOPIC, message.encode('utf-8'))
        print('------\nPublished: {} \nBroker(s): {}\nTopc: {}\n------'.format(
            message, KAFKA_BROKERS, KAFKA_TOPIC))
    except Exception as e:
        print(e)


if __name__ == '__main__':
    create_temp_ssl_files()

    producer = KafkaProducer(
        bootstrap_servers=KAFKA_BROKERS,
        security_protocol='SSL',
        ssl_cafile=SSL_CA_TEMP.name,
        ssl_certfile=SSL_CLIENT_TEMP.name,
        ssl_keyfile=SSL_KEY_TEMP.name
    )

    # Create 5 messages
    for i in range(0, 5):
        message = 'This is a random number: {}'.format(random.randint(0, 100))
        publish_message(message)
        time.sleep(1)
    producer.flush()
