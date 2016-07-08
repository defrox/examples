import json
import requests

username = "myusername" # change me to value in console->pipeline->connections
endpoint = "xxxxxx" # change me to value in console->pipeline->connections
pipeline = "brewery"  # change me to the pipeline name
topic = "{}_{}".format(username, pipeline)
schema_id = "52" # change to the value returned from the previous step
uri = "https://api.{}.vip.eventador.io/topics/{}".format(endpoint, topic)

payload = {}

# this is the ID for the schema to use, it was returned in the previous step
payload['value_schema_id'] = "{}".format(schema_id)

# this is the data you want to send in
payload['records'] = [
  {"value": {"sensor": "MashTun1", "temp":99}},
  {"value": {"sensor": "MashTun2", "temp":42}}
]

headers = {'Content-Type': 'application/vnd.kafka.avro.v1+json'}
r = requests.post(uri,
                  data=json.dumps(payload),
                  headers=headers)
print r.json()
