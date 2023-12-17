Here is a grafana agent config in flow mode for the hpe_exporter to send metrics to mimir/prometheus


This is the code that lets you target the actual SNMP Exporter you use

prometheus.scrape "hpe_array_exporter" {
    targets = [{
        __address__ = "hpe-array-exporter.nimble01.svc.cluster.local:9090",  Replace these address with youre exporter
        array       = "TMG-Nimble01",
    }]
    forward_to = [prometheus.relabel.hpe_array_exporter.receiver]
    job_name   = "hpe-array-exporter"
}


To use the HPE exporter view the helm directory