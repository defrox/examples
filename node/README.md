# Node Examples
For help getting started with Eventador checkout our [getting started guide](http://eventador.io/getting_started_guide.html).

The node examples utilize the [kafka-node](https://github.com/SOHU-Co/kafka-node) driver.

Included are both a produce and consume example, each respectively named, that simulate polling a beer brewing system and pushing data into the Eventador platform.

## Installation

To use these examples you will need node 0.10.x or higher on your machine.  If you don't have node set up yet, take a look at [nodejs.org](https://nodejs.org/en/download/current/) to get node installed on your system.  Once you have node installed, you can use npm to install the dependencies for these examples.

Installing requirements with npm:

```
npm install
```

This should read the provided package.json and install the kafka-node driver into a "node_modules" folder within the same directory that the examples then can use.

## Using the examples

To help initialize your environment for running these tests, please see [bootstrap_environment.sh](https://github.com/Eventador/examples/blob/master/bootstrap_environment.sh) in the parent directory.  

Running the producer:

```bash
node produce.js
```

Running the consumer:

```bash
node consumer.js
```

It should be noted that these examples are just that and may not show best practices for your given use case.
