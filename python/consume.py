import json
import requests
import time
from pprint import pprint

username = "myusername" # change me to value in console->pipeline->connections
endpoint = "xxxxxx" # change me to value in console->pipeline->connections
pipeline = "brewery"  # change me to the pipeline name
topic = "{}_{}".format(username, pipeline)
consumer_group = "my_group_of_application_servers" # logical group of consumers sharing offsets
consumer_uri = "https://api.{}.vip.eventador.io/consumers/{}".format(endpoint, consumer_group)

# register a new consumer (node)
register_consumer = {"format": "avro",
                     "auto.offset.reset": "largest" # start at most recent offset,
                                                    # can also use 'smallest',
                                                    # or omit entirely
                    }

r = requests.post(consumer_uri, data=json.dumps(register_consumer),
        headers={'Content-Type': 'application/vnd.kafka.v1+json'})

# this will contain our assigned endpoint to read messages from
base_uri = r.json()['base_uri']
print("Using endpoint: {}".format(base_uri))

# loop while polling for new messages
topic_uri = "{}/topics/{}".format(base_uri, topic)
while True:
    r = requests.get(topic_uri,
            headers={'Accept': 'application/vnd.kafka.avro.v1+json'})
    print r.json()
    time.sleep(1)
