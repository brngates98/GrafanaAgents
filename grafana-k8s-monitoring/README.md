This will contain the values.yaml for grafana-k8s-monitoring helm chart.

The values.yaml posted here is built to work with Mimir and Loki On-Prem and not grafana cloud as they use different endpoints

# How to install 

```helm repo add grafana https://grafana.github.io/helm-charts &&
  helm repo update &&
  helm upgrade --install --atomic --timeout 120s grafana-k8s-monitoring grafana/k8s-monitoring \
    --namespace "default" --create-namespace --values - <<EOF
cluster:
  kubernetesAPIService: kubernetes.default.svc.cluster.local:443
  name: CLUSTER-NAME
  platform: ''
configValidator:
  extraAnnotations: {}
  extraLabels: {}
  nodeSelector:
    kubernetes.io/os: linux
  tolerations: []
externalServices:
  loki:
    authMode: basic
    basicAuth:
      password: BASIC_AUTH_PASSWORD
      passwordKey: password
      username: 'BASIC_AUTH_USERNAME'
      usernameKey: username
    externalLabels: {}
    host: https://logs.yourdomain.com
    hostKey: host
    proxyURL: ''
    queryEndpoint: /loki/api/v1/query
    secret:
      create: true
      name: ''
      namespace: ''
    tenantId: ''
    tenantIdKey: tenantId
    tls: {}
    writeEndpoint: /loki/api/v1/push
  prometheus:
    authMode: basic
    basicAuth:
      password: BASIC_AUTH_PASSWORD
      passwordKey: password
      username: 'BASIC_AUTH_USERNAME'
      usernameKey: username
    externalLabels: {}
    host: https://mimir.yourdomain.com
    hostKey: host
    processors:
      batch:
        maxSize: 0
        size: 8192
        timeout: 2s
      memoryLimiter:
        checkInterval: 1s
        enabled: false
        limit: 0MiB
    protocol: remote_write
    proxyURL: ''
    queryEndpoint: /api/v1/query
    secret:
      create: true
      name: ''
      namespace: ''
    tenantId: ''
    tenantIdKey: tenantId
    tls: {}
    wal:
      maxKeepaliveTime: 8h
      minKeepaliveTime: 5m
      truncateFrequency: 2h
    writeEndpoint: /api/v1/push
    writeRelabelConfigRules: ''
  tempo:
    authMode: basic
    basicAuth:
      password: ''
      passwordKey: password
      username: ''
      usernameKey: username
    host: ''
    hostKey: host
    protocol: otlp
    searchEndpoint: /api/search
    secret:
      create: true
      name: ''
      namespace: ''
    tenantId: ''
    tenantIdKey: tenantId
    tls: {}
    tlsOptions: ''
extraConfig: ''
extraObjects: []
global:
  image:
    pullSecrets: []
    registry: ''
  cattle:
    systemProjectId: p-dkrnd
grafana-agent:
  agent:
    clustering:
      enabled: true
    configMap:
      create: false
    extraPorts:
      - name: otlp-grpc
        port: 4317
        protocol: TCP
        targetPort: 4317
      - name: otlp-http
        port: 4318
        protocol: TCP
        targetPort: 4318
      - name: prometheus
        port: 9999
        protocol: TCP
        targetPort: 9999
      - name: zipkin
        port: 9411
        protocol: TCP
        targetPort: 9411
    mounts:
      extra:
        - mountPath: /etc/kubernetes-monitoring-telemetry
          name: kubernetes-monitoring-telemetry
  controller:
    nodeSelector:
      kubernetes.io/os: linux
    type: statefulset
    volumes:
      extra:
        - configMap:
            name: kubernetes-monitoring-telemetry
          name: kubernetes-monitoring-telemetry
  crds:
    create: false
grafana-agent-events:
  agent:
    configMap:
      create: false
  controller:
    nodeSelector:
      kubernetes.io/os: linux
    type: deployment
  crds:
    create: false
grafana-agent-logs:
  agent:
    configMap:
      create: false
    mounts:
      dockercontainers: false
      varlog: true
  controller:
    nodeSelector:
      kubernetes.io/os: linux
    tolerations:
      - effect: NoSchedule
        operator: Exists
    type: daemonset
  crds:
    create: false
kube-state-metrics:
  autosharding:
    enabled: false
  enabled: true
  nodeSelector:
    kubernetes.io/os: linux
  updateStrategy: Recreate
logs:
  cluster_events:
    enabled: true
    logFormat: logfmt
    namespaces: []
  enabled: true
  extraConfig: ''
  pod_logs:
    annotation: k8s.grafana.com/logs.autogather
    discovery: all
    enabled: true
    extraRelabelingRules: ''
    extraStageBlocks: ''
    gatherMethod: volumes
    namespaces: []
metrics:
  agent:
    allowList:
      - agent_build_info
    enabled: true
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
    labelMatchers:
      app.kubernetes.io/name: grafana-agent.*
    scrapeInterval: ''
  apiserver:
    allowList: []
    enabled: false
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
    scrapeInterval: ''
  autoDiscover:
    annotations:
      instance: k8s.grafana.com/instance
      job: k8s.grafana.com/job
      metricsPath: k8s.grafana.com/metrics.path
      metricsPortName: k8s.grafana.com/metrics.portName
      metricsPortNumber: k8s.grafana.com/metrics.portNumber
      metricsScheme: k8s.grafana.com/metrics.scheme
      scrape: k8s.grafana.com/scrape
    enabled: true
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
  cadvisor:
    allowList:
      - container_cpu_cfs_periods_total
      - container_cpu_cfs_throttled_periods_total
      - container_cpu_usage_seconds_total
      - container_fs_reads_bytes_total
      - container_fs_reads_total
      - container_fs_writes_bytes_total
      - container_fs_writes_total
      - container_memory_cache
      - container_memory_rss
      - container_memory_swap
      - container_memory_working_set_bytes
      - container_network_receive_bytes_total
      - container_network_receive_packets_dropped_total
      - container_network_receive_packets_total
      - container_network_transmit_bytes_total
      - container_network_transmit_packets_dropped_total
      - container_network_transmit_packets_total
      - machine_memory_bytes
    enabled: true
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
    scrapeInterval: ''
  cost:
    allowList:
      - container_cpu_allocation
      - container_gpu_allocation
      - container_memory_allocation_bytes
      - deployment_match_labels
      - kubecost_cluster_info
      - kubecost_cluster_management_cost
      - kubecost_cluster_memory_working_set_bytes
      - kubecost_http_requests_total
      - kubecost_http_response_size_bytes
      - kubecost_http_response_time_seconds
      - kubecost_load_balancer_cost
      - kubecost_network_internet_egress_cost
      - kubecost_network_region_egress_cost
      - kubecost_network_zone_egress_cost
      - kubecost_node_is_spot
      - node_cpu_hourly_cost
      - node_gpu_count
      - node_gpu_hourly_cost
      - node_ram_hourly_cost
      - node_total_hourly_cost
      - opencost_build_info
      - pod_pvc_allocation
      - pv_hourly_cost
      - service_selector_labels
      - statefulSet_match_labels
    enabled: true
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
    labelMatchers:
      app.kubernetes.io/name: opencost
    scrapeInterval: ''
  enabled: true
  extraMetricRelabelingRules: ''
  extraRelabelingRules: ''
  kube-state-metrics:
    allowList:
      - kube_daemonset.*
      - kube_deployment_metadata_generation
      - kube_deployment_spec_replicas
      - kube_deployment_status_observed_generation
      - kube_deployment_status_replicas_available
      - kube_deployment_status_replicas_updated
      - kube_horizontalpodautoscaler_spec_max_replicas
      - kube_horizontalpodautoscaler_spec_min_replicas
      - kube_horizontalpodautoscaler_status_current_replicas
      - kube_horizontalpodautoscaler_status_desired_replicas
      - kube_job.*
      - kube_namespace_status_phase
      - kube_node.*
      - kube_persistentvolumeclaim_resource_requests_storage_bytes
      - kube_pod_container_info
      - kube_pod_container_resource_limits
      - kube_pod_container_resource_requests
      - kube_pod_container_status_last_terminated_reason
      - kube_pod_container_status_restarts_total
      - kube_pod_container_status_waiting_reason
      - kube_pod_info
      - kube_pod_owner
      - kube_pod_start_time
      - kube_pod_status_phase
      - kube_pod_status_reason
      - kube_replicaset.*
      - kube_resourcequota
      - kube_statefulset.*
    enabled: true
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
    labelMatchers:
      app.kubernetes.io/name: kube-state-metrics
    scrapeInterval: ''
    service:
      isTLS: false
      port: http
  kubeControllerManager:
    allowList: []
    enabled: false
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
    port: 10257
    scrapeInterval: ''
  kubeProxy:
    allowList: []
    enabled: false
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
    port: 10249
    scrapeInterval: ''
  kubeScheduler:
    allowList: []
    enabled: false
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
    port: 10259
    scrapeInterval: ''
  kubelet:
    allowList:
      - container_cpu_usage_seconds_total
      - kubelet_certificate_manager_client_expiration_renew_errors
      - kubelet_certificate_manager_client_ttl_seconds
      - kubelet_certificate_manager_server_ttl_seconds
      - kubelet_cgroup_manager_duration_seconds_bucket
      - kubelet_cgroup_manager_duration_seconds_count
      - kubelet_node_config_error
      - kubelet_node_name
      - kubelet_pleg_relist_duration_seconds_bucket
      - kubelet_pleg_relist_duration_seconds_count
      - kubelet_pleg_relist_interval_seconds_bucket
      - kubelet_pod_start_duration_seconds_bucket
      - kubelet_pod_start_duration_seconds_count
      - kubelet_pod_worker_duration_seconds_bucket
      - kubelet_pod_worker_duration_seconds_count
      - kubelet_running_container_count
      - kubelet_running_containers
      - kubelet_running_pod_count
      - kubelet_running_pods
      - kubelet_runtime_operations_errors_total
      - kubelet_runtime_operations_total
      - kubelet_server_expiration_renew_errors
      - kubelet_volume_stats_available_bytes
      - kubelet_volume_stats_capacity_bytes
      - kubelet_volume_stats_inodes
      - kubelet_volume_stats_inodes_used
      - kubernetes_build_info
      - namespace_workload_pod
      - rest_client_requests_total
      - storage_operation_duration_seconds_count
      - storage_operation_errors_total
      - volume_manager_total_volumes
    enabled: true
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
    scrapeInterval: ''
  kubernetesMonitoring:
    enabled: true
  node-exporter:
    allowList:
      - node_cpu.*
      - node_exporter_build_info
      - node_filesystem.*
      - node_memory.*
      - process_cpu_seconds_total
      - process_resident_memory_bytes
    enabled: true
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
    labelMatchers:
      app.kubernetes.io/name: prometheus-node-exporter.*
    scrapeInterval: ''
    service:
      isTLS: false
  podMonitors:
    enabled: true
    extraMetricRelabelingRules: ''
    namespaces: []
    scrapeInterval: ''
  probes:
    enabled: true
    extraMetricRelabelingRules: ''
    namespaces: []
    scrapeInterval: ''
  scrapeInterval: 60s
  serviceMonitors:
    enabled: true
    extraMetricRelabelingRules: ''
    namespaces: []
    scrapeInterval: ''
  windows-exporter:
    allowList:
      - windows_.*
      - node_cpu_seconds_total
      - node_filesystem_size_bytes
      - node_filesystem_avail_bytes
      - container_cpu_usage_seconds_total
    enabled: false
    extraMetricRelabelingRules: ''
    extraRelabelingRules: ''
    labelMatchers:
      app.kubernetes.io/name: prometheus-windows-exporter.*
    scrapeInterval: ''
opencost:
  enabled: true
  opencost:
    exporter:
      defaultClusterId: rke2-tmg
      extraEnv:
        CLOUD_PROVIDER_API_KEY: AIzaSyD29bGxmHAVEOBYtgd8sYM2gM2ekfxQX4U
        CURRENT_CLUSTER_ID_FILTER_ENABLED: 'true'
        EMIT_KSM_V1_METRICS: 'false'
        EMIT_KSM_V1_METRICS_ONLY: 'true'
        PROM_CLUSTER_ID_LABEL: cluster
    nodeSelector:
      kubernetes.io/os: linux
    prometheus:
      external:
        enabled: true
        url: https://mimir.yourdomain.com
      internal:
        enabled: false
      password_key: password
      secret_name: prometheus-k8s-monitoring
      username_key: username
    ui:
      enabled: false
prometheus-node-exporter:
  enabled: true
  nodeSelector:
    kubernetes.io/os: linux
prometheus-operator-crds:
  enabled: true
prometheus-windows-exporter:
  config: |-
    collectors:
      enabled: cpu,cs,container,logical_disk,memory,net,os
    collector:
      service:
        services-where: "Name='containerd' or Name='kubelet'"
  enabled: false
receivers:
  grpc:
    disable_debug_metrics: true
    enabled: true
    port: 4317
  http:
    disable_debug_metrics: true
    enabled: true
    port: 4318
  prometheus:
    enabled: false
    port: 9999
  zipkin:
    disable_debug_metrics: true
    enabled: false
    port: 9411
test:
  attempts: 10
  envOverrides:
    LOKI_URL: ''
    PROMETHEUS_URL: ''
    TEMPO_URL: ''
  extraAnnotations: {}
  extraLabels: {}
  extraQueries: []
  image:
    image: grafana/k8s-monitoring-test
    pullSecrets: []
    registry: ghcr.io
    tag: ''
  nodeSelector:
    kubernetes.io/os: linux
  tolerations: []
traces:
  enabled: false
  processors:
    batch:
      maxSize: 0
      size: 16384
      timeout: 2s
EOF
```
