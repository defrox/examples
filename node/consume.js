var fs = require('fs');
var kafka = require('kafka-node');

// Pull in configuration
var Config = require("./config");
var config = new Config();

var consumerOptions = {
    groupId: config.KAFKA_CONSUMER_GROUP
};
// Consume takes a list of payloads or topics to subscribe to with respective per topic options if needed
var topicSubscriptions = [
    {
        topic: config.KAFKA_TOPIC
    }
]

// Client config placeholders
zkOptions = {};
noAckBatchOptions = {};
// Setup SSL options if we are configured to use SSL
var sslOptions = {};
if (config.KAFKA_USE_SSL) {
    sslOptions.ca = fs.readFileSync(config.KAFKA_CA_CERT);
    sslOptions.cert = fs.readFileSync(config.KAFKA_CLIENT_CERT);
    sslOptions.key = fs.readFileSync(config.KAFKA_CLIENT_KEY);
}

// Initialize our kafka client and consumer objects
var Consumer = kafka.HighLevelConsumer,
    KeyedMessage = kafka.KeyedMessage,
    client = new kafka.Client(config.ZOOKEEPER_ENSEMBLE, config.KAFKA_CLIENT_ID, zkOptions, noAckBatchOptions, sslOptions),
    consumer = new Consumer(client, topicSubscriptions, consumerOptions);

// Output a little data about what we connected to
console.log('Connected to Zookeepers:', config.ZOOKEEPER_ENSEMBLE, 'Using topic:', config.KAFKA_TOPIC);
console.log('Found the following brokers:', Object.keys(client.brokers).join(','));
console.log('Using SSL:', client.ssl);

// Basic main run loop once consumer is connected
consumer.on('message', function(message) {
    console.log(message);
});

consumer.on('error', function (err) {
    console.error("ERROR", err);
})
