// Configuration loader
var Yaml = require('js-yaml');
// Read in environment variables supplied by ../bootstrap_environment.sh or set defaults
function Config() {
    this.KAFKA_BROKERS = process.env.EVENTADOR_BOOTSTRAP_SERVERS || "localhost:9092";
    this.KAFKA_TOPIC = process.env.EVENTADOR_KAFKA_TOPIC || "defaultsink";
    this.KAFKA_USE_SSL = Yaml.load(process.env.EVENTADOR_KAFKA_USE_SSL || "false");
    this.KAFKA_CA_CERT = process.env.EVENTADOR_KAFKA_CA_CERT || "";
    this.KAFKA_CLIENT_CERT = process.env.EVENTADOR_KAFKA_CLIENT_CERT || "";
    this.KAFKA_CLIENT_KEY = process.env.EVENTADOR_KAFKA_CLIENT_KEY || "";
    this.KAFKA_CONSUMER_GROUP = process.env.EVENTADOR_KAFKA_CONSUMER_GROUP || "myconsumer-node";
    this.KAFKA_CLIENT_ID = process.env.EVENTADOR_KAFKA_CLIENT_ID || "myid-node";
    this.ZOOKEEPER_ENSEMBLE = process.env.EVENTADOR_ZOOKEEPER_ENSEMBLE || "localhost:2181";
}

module.exports = Config;
