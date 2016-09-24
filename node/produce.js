var fs = require('fs');
var kafka = require('kafka-node');

// Pull in configuration
var Config = require("./config");
var config = new Config();

var producerOptions = {
    partitionerType: 2 // 1: random placement in topic partitions, 2: round-robin
};

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

// Our mock sensors
var sensors = ['MashTun1', 'MashTun2'];

// Simple function to mock pulling data from a brewery sensor and returning stringified JSON
function sample_sensor(sensor) {
    data = {
        sensor: sensor,
        temp: Math.floor(Math.random() * (60) + 30)
    };

    return JSON.stringify(data);
};

// Poll our sensors and send the data to kafka
function push_sensor_data() {
    messages = [];

    sensors.forEach(function(sensor) {
        data = sample_sensor(sensor);
        messages.push(data);
    });

    payloads = [{
        topic: config.KAFKA_TOPIC,
        messages: messages
    }];

    producer.send(payloads, function(err, data) {
        if (err) {
            console.error(err);
        } else {
            console.log(data);
        }
    });
}

// Initialize our kafka client and producer objects
var Producer = kafka.HighLevelProducer,
    KeyedMessage = kafka.KeyedMessage,
    client = new kafka.Client(config.ZOOKEEPER_ENSEMBLE, config.KAFKA_CLIENT_ID, zkOptions, noAckBatchOptions, sslOptions),
    producer = new Producer(client, producerOptions);

// Basic main run loop once producer is connected
producer.on('ready', function() {
    // Output a little data about what we connected to
    console.log('Connected to Zookeepers:', config.ZOOKEEPER_ENSEMBLE, 'Using topic:', config.KAFKA_TOPIC);
    console.log('Found the following brokers:', Object.keys(client.brokers).join(','));
    console.log('Using SSL:', client.ssl);

    // Must refresh state of topic before sending data to avoid losing first message
    client.refreshMetadata([config.KAFKA_TOPIC], function() {
        console.log('Refreshed partition metadata for topic:', config.KAFKA_TOPIC);
    });
    // Poll our sensers ever 3 seconds
    setInterval(push_sensor_data, 3000);
});

producer.on('error', function (err) {
    console.error("ERROR", err);
})
