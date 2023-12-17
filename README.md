# GrafanaAgents

This repo is dedicated to keeping a collection of common configs for Grafana Agents.


All files in here have been tested to work in Binary Installs of Grafana Agents, and Installs in Kubernetes.

My workflow is as follows.

Build initial config on my development vm(Ubuntu Server 22.04LTS) install Grafana Agent, Build Config, Do Testing.

Once satisfied i convert the configs to flow mode, and then implement them in Kubernetes.



# Mimir and Prometheus Remote Write URLs
To save the hassle of needing to build configs for both types for everyone, i built this explanation

To use these agent configs there is a few things to keep in mind.

Remote Write URLS for Metrics, my url's are all designed around Mimir however if you want to use Prometheus instead use the below guide for url structure.
Loki related items should generally work fine.

Prometheus Remote Write URL and Requirements

http://prometheus/api/v1/write

Feature Flag  --web.enable-remote-write-receiver 
Full example
/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --web.enable-remote-write-receiver


Mimir Remote Write URL and Requirements
Mimir installed
https://mimir/api/v1/push

