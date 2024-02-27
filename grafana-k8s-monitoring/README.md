This will contain the values.yaml for grafana-k8s-monitoring helm chart.

The values.yaml posted here is built to work with Mimir and Loki On-Prem and not grafana cloud as they use different endpoints

This read me will contain various snippets for OSS and Grafana Cloud

# How to install the Kubernetes Monitoring Grafana Agent

# Mimir/Loki OSS - Metrics/Logs Only
Replace "my-cluster" with youre cluster name
```
helm repo add grafana https://grafana.github.io/helm-charts &&
  helm repo update &&
  helm upgrade --install --atomic --timeout 300s grafana-k8s-monitoring grafana/k8s-monitoring \
    --namespace "default" --create-namespace --values - <<EOF
cluster:
  name: rke2-tmg
externalServices:
  prometheus:
    host: https://mimir.thetmg.com
    queryEndpoint: /api/v1/query
    writeEndpoint: /api/v1/push
    basicAuth:
      username: "1083092"
      password: REPLACE_WITH_ACCESS_POLICY_TOKEN
  loki:
    host: https://logs.thetmg.com
    queryEndpoint: /loki/api/v1/query
    writeEndpoint: /loki/api/v1/push
    basicAuth:
      username: "642165"
      password: REPLACE_WITH_ACCESS_POLICY_TOKEN
metrics:
  enabled: true
  cost:
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
opencost:
  enabled: true
  opencost:
    exporter:
      defaultClusterId: rke2-tmg
    prometheus:
      external:
        url: https://mimir.thetmg.com
kube-state-metrics:
  enabled: true
prometheus-node-exporter:
  enabled: true
prometheus-operator-crds:
  enabled: true
grafana-agent: {}
grafana-agent-logs: {}
EOF
```

# Grafana Cloud - Metrics/Logs/Traces
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
      username: "username"
      password: REPLACE_WITH_ACCESS_POLICY_TOKEN
  loki:
    host: https://logs-prod-006.grafana.net
    basicAuth:
      username: "username"
      password: REPLACE_WITH_ACCESS_POLICY_TOKEN
metrics:
  enabled: true
  cost:
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
grafana-agent: {}
grafana-agent-logs: {}
EOF

```
