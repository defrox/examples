#!/usr/bin/env ruby
require "json"
require "kafka"
require "yaml"

# Kafka brokers seedlist
brokers = ENV.fetch("KAFKA_BROKERS", "localhost:9092").split(",")

# Topic
topic = ENV.fetch("KAFKA_TOPIC", "defaultsink")

### SSL configuration
use_ssl = YAML.load(ENV.fetch("KAFKA_USE_SSL", "false"))
ca_cert = ENV.fetch("KAFKA_CA_CERT", nil)
client_cert = ENV.fetch("KAFKA_CLIENT_CERT", nil)
client_key = ENV.fetch("KAFKA_CLIENT_KEY", nil)

# Kafka client id
client_id = ENV.fetch("KAFKA_CLIENT_ID", "ruby-producer")

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

# Async producer for buffered messaging
async_producer = kafka.async_producer

# Sample events from our beer sensors
sensors = ["MashTun1", "MashTun2"]

puts "Producing to topic: #{topic}"

# Trap ctrl-c and request exit
Kernel.trap("SIGTERM") { exit_requested = true }

exit_requested = false
# Produce until killed
while !exit_requested
    # Push sensor temp onto buffer
    sensors.each do |sensor|
        data = JSON.dump({"sensor" => sensor, "temp" => rand(30..90)})
        async_producer.produce(data, topic: topic)
        puts "#{data}"
    end
    # Deliver the messages on the buffer
    async_producer.deliver_messages
    # sleep every 3 seconds
    sleep(3)
end
# Ensure we close the async producer
async_producer.shutdown
