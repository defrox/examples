#!/bin/bash
## Setup environment variables used by Eventador examples
#
# Load via: . ./bootstrap_environment.sh
#

# Pull the list of brokers from your deployment's connections tab
export EVENTADOR_BOOTSTRAP_SERVERS="localhost:9092"
# Topic you wish you use.
export EVENTADOR_KAFKA_TOPIC="defaultsink"
# Use to toggle SSL support within the provided examples
export EVENTADOR_KAFKA_USE_SSL="false"
# Pull these values from your deployment's security tab, after creating a client certificate
export EVENTADOR_KAFKA_CA_CERT=""
export EVENTADOR_KAFKA_CLIENT_CERT=""
export EVENTADOR_KAFKA_CLIENT_KEY=""
# Identify with a specific consumer group for splitting messages between multiple consumers
export EVENTADOR_KAFKA_CONSUMER_GROUP="myconsumer"
# Identify a specific client with a unique ID, helpful for looking through logs
export EVENTADOR_KAFKA_CLIENT_ID="myid"
# Pull the list of zookeepers from your deployment's connections tab
export EVENTADOR_ZOOKEEPER_ENSEMBLE="localhost:2181"
