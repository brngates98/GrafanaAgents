# Important Update
This is now based on the Alloy Agent!
I have updated the values.yaml appropriately.
This will contain the values.yaml for grafana-k8s-monitoring helm chart.

The values.yaml posted here is built to work with Mimir and Loki On-Prem and not grafana cloud as they use different endpoints

This read me will contain various snippets for OSS and Grafana Cloud

# How to install the Kubernetes Monitoring Grafana Alloy Agent

# Mimir/Loki OSS - Metrics/Logs Only
Replace "my-cluster" with youre cluster name and https://mimir & https://loki with youre endpoint
```
helm repo add grafana https://grafana.github.io/helm-charts &&
  helm repo update &&
  helm upgrade --install --atomic --timeout 300s grafana-k8s-monitoring grafana/k8s-monitoring \
    --namespace "agents" --create-namespace --values - <<EOF
cluster:
  name: tmg-rke2-prod
externalServices:
  prometheus:
    host: https://mimir
    queryEndpoint: /api/v1/query
    writeEndpoint: /api/v1/push
    basicAuth:
      username: "1083092"
      password: REPLACE_WITH_ACCESS_POLICY_TOKEN
  loki:
    host: https://logs
    queryEndpoint: /loki/api/v1/query
    writeEndpoint: /loki/api/v1/push
    basicAuth:
      username: "642165"
      password: REPLACE_WITH_ACCESS_POLICY_TOKEN
metrics:
  enabled: true
  alloy:
    metricsTuning:
      useIntegrationAllowList: true
  cost:
    enabled: true
  kepler:
    enabled: true
  node-exporter:
    enabled: true
logs:
  enabled: true
  pod_logs:
    enabled: true
  cluster_events:
    enabled: true
traces:
  enabled: false
receivers:
  grpc:
    enabled: false
  http:
    enabled: false
  zipkin:
    enabled: false
  grafanaCloudMetrics:
    enabled: false
opencost:
  enabled: true
  opencost:
    exporter:
      defaultClusterId: tmg-rke2-prod
    prometheus:
      external:
        url: https://mimir
kube-state-metrics:
  enabled: true
prometheus-node-exporter:
  enabled: true
prometheus-operator-crds:
  enabled: true
kepler:
  enabled: true
alloy: {}
alloy-events: {}
alloy-logs: {}
EOF
```

# Grafana Cloud - Metrics/Logs
```
helm repo add grafana https://grafana.github.io/helm-charts &&
  helm repo update &&
  helm upgrade --install --atomic --timeout 300s grafana-k8s-monitoring grafana/k8s-monitoring \
    --namespace "default" --create-namespace --values - <<EOF
cluster:
  name: my-cluster
externalServices:
  prometheus:
    host: https://prometheus-prod-13-prod-us-east-0.grafana.net
    basicAuth:
      username: "REPLACE_WITH_USERNAME"
      password: REPLACE_WITH_ACCESS_POLICY_TOKEN
  loki:
    host: https://logs-prod-006.grafana.net
    basicAuth:
      username: "REPLACE_WITH_USERNAME"
      password: REPLACE_WITH_ACCESS_POLICY_TOKEN
  tempo:
    host: https://tempo-prod-04-prod-us-east-0.grafana.net:443
    basicAuth:
      username: "638669"
      password: REPLACE_WITH_ACCESS_POLICY_TOKEN
metrics:
  enabled: true
  alloy:
    metricsTuning:
      useIntegrationAllowList: true
  cost:
    enabled: true
  kepler:
    enabled: true
  node-exporter:
    enabled: true
logs:
  enabled: true
  pod_logs:
    enabled: true
  cluster_events:
    enabled: true
traces:
  enabled: true
receivers:
  grpc:
    enabled: true
  http:
    enabled: true
  zipkin:
    enabled: true
  grafanaCloudMetrics:
    enabled: false
opencost:
  enabled: true
  opencost:
    exporter:
      defaultClusterId: my-cluster
    prometheus:
      external:
        url: https://prometheus-prod-13-prod-us-east-0.grafana.net/api/prom
kube-state-metrics:
  enabled: true
prometheus-node-exporter:
  enabled: true
prometheus-operator-crds:
  enabled: true
kepler:
  enabled: true
alloy: {}
alloy-events: {}
alloy-logs: {}
EOF

```
