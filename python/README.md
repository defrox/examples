# Python Examples

These are examples of how to produce and consume data to/from eventador.io using python.

## Using the examples

To use the examples you need python 2.6+ on your machine. It's most likely already installed, but if not here is a [installation guide](http://docs.python-guide.org/en/latest/starting/installation/).

You will need to know the following variables and change them in the code. The values can be found in the eventador.io console under the 'connections' tab for a specific pipeline.

```python
username = "myusername" # change me to value in console->pipeline->connections
endpoint = "xxxxxx"     # change me to value in console->pipeline->connections
pipeline = "brewery"    # change me to the pipeline name
```

Once the values are changed to match your account, you can run the examples like:

```bash
python produce.py
```

It should be noted the examples should be tailored to your specific use case, these are just examples.

## Going further

Check out the eventador.io [getting started guide](https://eventador.github.io/documentation/getting_started_guide.html) for a complete example.
