# nut-influxdbv2
Docker image to pulls data from a NUT server and push it to an InfluxDB bucket. Based on work of mihai-cindea [https://github.com/mihai-cindea/nut-influxdb-exporter)

## Changes
- Updated for InfluxDBv2.
- Changed outputted values.
- Poll multiple NUT servers.
- Poll internal batteries on MacOS using the NUT macosx-ups driver.
- Use a python 3.12 - slim - bookwork lighter container as base

## Roadmap
Telegraf 1.24 introduced built-in support for NUTS servers https://docs.influxdata.com/telegraf/v1.24/plugins/#input-upsd and https://github.com/influxdata/telegraf/blob/release-1.24/plugins/inputs/upsd/README.md, as implemented with this PR https://github.com/influxdata/telegraf/pull/9890/files#diff-60ad28a279b042acced351b6dd19a9a339d8349d6ab603054345bd23bd279462. The use of the standard telegraf input plugins is prefered for a robust implementation and this code will be no longer be maintained as my personal use-case is meet by the current input plugin.

https://github.com/influxdata/telegraf/tree/master/plugins/inputs/upsd

# Setup

## NUT Servers
- Get IP address of NUT servers
- Create list of hostnames (mapped to hosts in Influx): ['Host1','Host2', ...]

## InfluxDBv2 Setup
Setup InfluxDBv2, create bucket and create a token with write permissions for bucket.

## Docker Setup
https://hub.docker.com/repository/docker/dbsqp/nut-influxdbv2
```
$ docker run -d \
 -e NUT_HOST_LIST="['Host1','Host2',...]" \
 -e NUT_PORT="3493" \
 -e NUT_PASSWORD="secret" \
 -e NUT_USERNAME="monuser" \
 -e NUT_UPSNAME="ups" \
 -e INFLUXDB2_HOST="<INFLUXDBv2 SERVER>" \
 -e INFLUXDB2_PORT="8086" \
 -e INFLUXDB2_ORG="Home" \
 -e INFLUXDB2_TOKEN="" \
 -e INFLUXDB2_BUCKET="DEV" \
 --name "Nut-InfluxDBv2" \
dbsqp/nut-influxdbv2:dev
```

### Options
```
 -e INFLUXDB2_SSL="True" \
 -e INFLUXDB2_SSL_VERIFY="False"
```

### Debug
To report out further details in the log enable debug:
```
 -e DEBUG="true"
```
