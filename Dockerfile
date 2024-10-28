ARG ARCH=

# Pull base image
FROM python:3.12-slim-bookworm

# Labels
LABEL MAINTAINER="https://github.com/dbsqp/"

# Setup external package-sources
RUN apt update && apt upgrade -y && apt install -y \
    python3 \
    python3-dev \
    python3-setuptools \
    python3-pip \
    python3-virtualenv && \
    rm -rf /var/lib/apt/lists/*

# RUN pip install setuptools
RUN pip3 install pytz nut2 influxdb-client

# Environment vars
ENV PYTHONIOENCODING=utf-8

# Copy files
ADD nut-influxdbv2-exporter.py /
ADD get.sh /

# Run
CMD ["/bin/bash","/get.sh"]
