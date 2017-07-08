# Python Examples
For help getting started with Eventador checkout our [getting started guide](http://eventador.io/getting_started_guide.html).

These are examples of how to produce and consume data to/from eventador.io using python.

## Installation

To use the examples you need python 2.6+ on your machine. It's most likely already installed, but if not here is a [installation guide](http://docs.python-guide.org/en/latest/starting/installation/). Using Virtualenv is recommended of course.

Installing requirements:

```
pip install -r requirements.txt
```

## Using the examples

You will need to know the following variables and change them in the code. The values can be found in the eventador.io console under the 'connections' tab for a specific pipeline.

```python
EVENTADOR_KAFKA_TOPIC = "brewery"  # any topic name, will autocreate if needed
EVENTADOR_BOOTSTRAP_SERVERS = "my bootstrap servers"  # value from deployments tab in UI
```

Once the values are changed to match your account, you can run the examples like:

```bash
python produce.py
```

It should be noted the examples should be tailored to your specific use case, these are just examples.

