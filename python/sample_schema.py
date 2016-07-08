import json
import requests
from pprint import pprint

username = "myusername" # change me to value in console->pipeline->connections
endpoint = "xxxxxx" # change me to value in console->pipeline->connections
pipeline = "brewery"  # change me to the pipeline name
topic = "{}_{}".format(username, pipeline)
uri = "https://schema-registry.{}.vip.eventador.io/subjects/{}-value/versions".format(endpoint, topic)

# schema is two values: sensor (string), temp (int)
payload = {}
payload['schema'] = """
  {"type": "record",
   "name": "mybreweryschema",
   "fields": [
      {"name": "sensor", "type": "string"},
      {"name": "temp", "type": "int"}
]}
"""

headers = {'Content-Type': 'application/vnd.schemaregistry.v1+json'}
r = requests.post(uri,
                  data=json.dumps(payload),
                  headers=headers)

pprint(r.json())
