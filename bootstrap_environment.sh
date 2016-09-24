#!/bin/bash
## Setup environment variables used by Eventador examples
#
# Load via: . ./bootstrap_environment.sh
#

# Pull the list of brokers from your deployment's connections tab
export KAFKA_BROKERS="localhost:9092"
# Topic you wish you use.
export KAFKA_TOPIC="defaultsink"
# Use to toggle SSL support within the provided examples
export KAFKA_USE_SSL="false"
# Pull these values from your deployment's security tab, after creating a client certificate
export KAFKA_CA_CERT=""
export KAFKA_CLIENT_CERT=""
export KAFKA_CLIENT_KEY=""
# Identify with a specific consumer group for splitting messages between multiple consumers
export KAFKA_CONSUMER_GROUP="myconsumer"
# Identify a specific client with a unique ID, helpful for looking through logs
export KAFKA_CLIENT_ID="myid"
# Pull the list of zookeepers from your deployment's connections tab
export ZOOKEEPER_ENSEMBLE="localhost:2181"
