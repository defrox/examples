#!/bin/bash
## Setup environment variables used by Eventador examples
#
# Load via: . ./bootstrap_environment.sh
#

export KAFKA_BROKERS="localhost:9092"
export KAFKA_TOPIC="defaultsink"
export KAFKA_USE_SSL="false"
export KAFKA_CA_CERT=""
export KAFKA_CLIENT_CERT=""
export KAFKA_CLIENT_KEY=""
export KAFKA_CONSUMER_GROUP="myconsumer"
export KAFKA_CLIENT_ID="myid"
export ZOOKEEPER_ENSEMBLE="localhost:2181"
