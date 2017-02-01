#!/usr/bin/env ruby
require "json"
require "kafka"
require "yaml"

# Kafka brokers seedlist
brokers = ENV.fetch("EVENTADOR_BOOTSTRAP_SERVERS", "localhost:9092").split(",")

# Topic
topic = ENV.fetch("EVENTADOR_KAFKA_TOPIC", "defaultsink")

### SSL configuration
use_ssl = YAML.load(ENV.fetch("EVENTADOR_KAFKA_USE_SSL", "false"))
ca_cert = ENV.fetch("EVENTADOR_KAFKA_CA_CERT", nil)
client_cert = ENV.fetch("EVENTADOR_KAFKA_CLIENT_CERT", nil)
client_key = ENV.fetch("EVENTADOR_KAFKA_CLIENT_KEY", nil)

# Consumer Group assignment
consumer_group = ENV.fetch("EVENTADOR_KAFKA_CONSUMER_GROUP", "ruby-consumer-group")

# Kafka client id
client_id = ENV.fetch("EVENTADOR_KAFKA_CLIENT_ID", "ruby-producer")

# Start a logger
logger = Logger.new("producer.log")

if use_ssl
    # Initialize kafka using SSL
    kafka = Kafka.new(
        # Inherit the local logger
        logger: logger,
        # Broker list
        seed_brokers: brokers,
        # Client identifier
        client_id: client_id,
        # SSL bits pulled from environment variables
        ssl_ca_cert: File.read(ca_cert),
        ssl_client_cert: File.read(client_cert),
        ssl_client_cert_key: File.read(client_key),
    )
else
    # Initialize kafka using plaintext
    kafka = Kafka.new(
            logger: logger,
            seed_brokers: brokers,
            client_id: client_id,
    )
end

# Consumers with the same group id will form a Consumer Group together.
consumer = kafka.consumer(group_id: consumer_group)

# Trap kill and ctrl-c
trap("SIGINT") { consumer.stop }
trap("QUIT") { consumer.stop }

# Subscribe to configured topic
consumer.subscribe(topic)

puts "Subscribed to topic: #{topic}.  Waiting for messages..."

# Loop indefinitely over messages in the subscribed topic
consumer.each_message do |message|
    # Print out partition::offset ==> key::value
    puts "#{message.partition}::#{message.offset} ==> #{message.key}::#{message.value}"
end
