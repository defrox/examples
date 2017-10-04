#!/bin/bash
## Setup environment variables used by Eventador examples
#
# Load via: . ./bootstrap_environment.sh
#

### Required

# Pull the list of brokers from your deployment's connections tab
export EVENTADOR_PLAINTEXT_ENDPOINT="localhost:9092"

# Topic you wish you use.
export EVENTADOR_KAFKA_TOPIC="demo"

### Advanced Setup

# SSL endpoint
export EVENTADOR_SSL_ENDPOINT="localhost:9093"

# Pull these values from your deployment's security tab, after creating a client certificate
export EVENTADOR_KAFKA_CA_CERT="-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----"
export EVENTADOR_KAFKA_CLIENT_CERT="-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----
"
export EVENTADOR_KAFKA_CLIENT_KEY="-----BEGIN PRIVATE KEY-----
-----END PRIVATE KEY-----"

# Identify with a specific consumer group for splitting messages between multiple consumers
export EVENTADOR_KAFKA_CONSUMER_GROUP="myconsumer"
# Identify a specific client with a unique ID, helpful for looking through logs
export EVENTADOR_KAFKA_CLIENT_ID="demo_id"
# Pull the list of zookeepers from your deployment's connections tab
export EVENTADOR_ZOOKEEPER_ENSEMBLE="localhost:2181"
