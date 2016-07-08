# This example produces sample records to our example "brewery" pipeline
# storing synthesized sensor data

require 'json'
require 'net/http'
require 'uri'

TOPIC = "yourlogin_brewery"
SCHEMA_ID = 2 ## the global unique schema ID to use for these records,
              ## query-able via the schema-registry.  In this case,
              ## this schema enforces a document containing a string
              ## called 'sensor', and an integer called 'temp'

uri = URI.parse("https://api.YOURDEPLOYMENT.eventador.io/topics/" + TOPIC)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Post.new(uri.request_uri, 
                              initheader = {'Content-Type' =>'application/vnd.kafka.avro.v1+json'})

# synthesize data records and set schema to enforce
sample = {"records" => 
           [
               {"value" => {"sensor" => "RubyBeerSensor1", "temp" => 68}},
               {"value" => {"sensor" => "RubyBeerSensor2", "temp" => 42}}
           ],
          "value_schema_id" => SCHEMA_ID}

# serialize hash to json, send request, and return results
request.body = sample.to_json
response = http.request(request)
parsed = JSON.parse(response.body)
puts parsed
