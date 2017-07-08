# Ruby Examples
For help getting started with Eventador checkout our [getting started guide](http://eventador.io/getting_started_guide.html).

The ruby examples utilize the ZenDesk [ruby-kafka](https://github.com/zendesk/ruby-kafka) driver.

Included are both a produce and consume example, each respectively named, that simulate polling a beer brewing system and pushing data into the Eventador platform.

## Installation

To use these examples you will need ruby 1.9.3 or higher on your machine.  If you don't have ruby set up yet, take a look at [rbenv](https://github.com/rbenv/rbenv) to get started with a simple ruby environment.

You will also need the bundler gem installed:

```
gem install bundler
```

Installing requirements with bundler:

```
bundle install
```

This should read the provided Gemfile and install the ruby-kafka gem into your environment.

## Using the examples

To help initialize your environment for running these tests, please see [bootstrap_environment.sh](https://github.com/Eventador/examples/blob/master/bootstrap_environment.sh) in the parent directory.

Running the producer:

```bash
ruby produce.rb
```

Running the consumer:

```bash
ruby consumer.rb
```

It should be noted the examples should be tailored to your specific use case, these are just examples.
