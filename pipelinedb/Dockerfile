FROM pipelinedb/pipelinedb:latest
MAINTAINER Eventador Docker <docker@eventador.io>

RUN mkdir /opt/eventador/
RUN mkdir /opt/eventador/examples
COPY brewery_example.sql /opt/eventador/examples/

WORKDIR /opt/eventador/examples
ENTRYPOINT []
USER root
