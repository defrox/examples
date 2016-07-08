# This example will query for information regarding a specific topic,
# and pretty-print the resulting response

require 'json'
require 'net/http'
require 'uri'

TOPIC = "yourlogin_brewery"

uri = URI.parse("https://api.YOURDEPLOYMENT.eventador.io/topics/" + TOPIC)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
json_parsed = JSON.parse(response.body)
puts JSON.pretty_generate(json_parsed)
