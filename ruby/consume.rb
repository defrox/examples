# This example will register a consumer, and then consume the next available
# message(s) and deserialize them

require 'json'
require "net/http"
require "uri"

CONSUMER_GROUP = "brewery_consumer_group" # can be any name identifying a group
                                          # of servers doing similar work
TOPIC = "yourlogin_brewery"                  # sample topic logging sensor data

# register our consumer
uri = URI.parse("https://api.YOURDEPLOYMENT.eventador.io/consumers/" + CONSUMER_GROUP)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Post.new(uri.request_uri, 
                              initheader = {'Content-Type' =>'application/vnd.kafka.v1+json'})

request.body = '{"format": "avro", 
                 "auto.offset.reset": "largest"}' # indicate that we're using avro
                                                  # to encode the data, and we'd like to
                                                  # start consuming from the latest message
http_response = http.request(request)

json_response = JSON.parse http_response.body     # retrieve our registered kafka-rest endpoint
endpoint = json_response['base_uri']

# consume messages and deserialize json 
consumer_uri = URI.parse(endpoint + "/topics/" + TOPIC)
consumer_http = Net::HTTP.new(consumer_uri.host, consumer_uri.port)
consumer_http.use_ssl = true

consumer_request = Net::HTTP::Get.new(consumer_uri.request_uri, 
                                      initheader = {'Accept' =>'application/vnd.kafka.avro.v1+json'})

consumer_http_response = consumer_http.request(consumer_request)
json_response = JSON.parse consumer_http_response.body
puts json_response
