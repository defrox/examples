# SQL Examples

These are example of how to build various continuous views in pipelineDB on the eventador.io platform.


## Using the examples

To create these examples you need to connect to your eventador.io database, and run the commands via a psql client. You will need to install psql on your local environment. Here is a good [tutorial](https://www.codefellows.org/blog/three-battle-tested-ways-to-install-postgresql) on installing PostgreSQL. It should be noted to use eventador you only need the client.

Once complete, You can do this in a single step like this:

```bash
psql -U airplane_demo -h xxx99aa.va.eventador.io -p 9000 -f latest_latlong_by_tailnumber.sql airplane_demo
```

You can find your connection details under the 'connections' tab in the [eventador.io console](http://console.eventador.io/). See the [getting started](https://eventador.github.io/documentation/getting_started_guide.html) guide for more details.

## Going further

It's important to remember that any commands that work in PipelineDB and PostgreSQL work on eventador.io. Check out the [PipelineDB docs](http://docs.pipelinedb.com/index.html) and the [PostgreSQL docs](https://www.postgresql.org/docs/9.5/static/index.html) for more information.
