from kafka import KafkaProducer

KAFKA_TOPIC = 'demo'
KAFKA_BROKERS='<value_from_plain_text_endpoint>'

producer = KafkaProducer(bootstrap_servers=KAFKA_BROKERS)

# Must send bytes
messages = [b'hello kafka', b'I am sending', b'3 test messages']

# Send the messages
for m in messages:
    producer.send(KAFKA_TOPIC, m)
