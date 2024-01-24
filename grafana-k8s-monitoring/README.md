This will contain the values.yaml for grafana-k8s-monitoring helm chart.

The values.yaml posted here is built to work with Mimir and Loki On-Prem and not grafana cloud as they use different endpoints

# How to install 

```
helm repo add grafana https://grafana.github.io/helm-charts &&
  helm repo update &&
  helm upgrade --install --atomic --timeout 120s grafana-k8s-monitoring grafana/k8s-monitoring \
    --namespace "default" --create-namespace --values - <<EOF
cluster:
  name: my-cluster
externalServices:
  prometheus:
    host: https://mimir.yourdomain.com
    queryEndpoint: /api/v1/query
    writeEndpoint: /api/v1/push
    basicAuth:
      username: "USERNAME"
      password: PASSWORD
  loki:
    host: https://logs.yourdomain.com
    queryEndpoint: /loki/api/v1/query
    writeEndpoint: /loki/api/v1/push
    basicAuth:
      username: "USERNAME"
      password: PASSWORD
opencost:
  opencost:
    exporter:
      defaultClusterId: my-cluster
    prometheus:
      external:
        url: https://mimir.yourdomain.com
EOF
```
