# Using Alloy as a Generic Syslog Receiver

This guide explains how to configure the Grafana Alloy agent to receive syslog messages from various sources and forward them to a Loki server for centralized logging and analysis.

### Configuration Overview
1. **Syslog Listener Setup**:
   - Listens on two ports to capture syslog messages from different protocols:
     - **TCP** on port **601**
     - **UDP** on port **514**
   - Uses `0.0.0.0` as the address, allowing the server to listen on all available IPs.

2. **Relabeling Rules**:
   - Relabeling rules map syslog message metadata to more descriptive labels for enhanced filtering and analysis in Loki:
     - **host** and **hostname** are derived from the `__syslog_message_hostname`.
     - **level** is set based on `__syslog_message_severity`.
     - **application** is labeled using `__syslog_message_app_name`.
     - **facility** and **connection_hostname** are mapped from `__syslog_message_facility` and `__syslog_connection_hostname`, respectively.

3. **Forwarding to Loki**:
   - After processing and labeling, the messages are forwarded to a specified Loki server endpoint for storage and retrieval.
   - Replace `https://loki.tld/loki/api/v1/push` with the domain or IP address of your own Loki server.

### Actual Configuration
Below is an example configuration for setting up Alloy as a syslog receiver with relabeling and forwarding to Loki.

```hcl
# Discovery and Relabel Rules
discovery.relabel "syslog" {
    targets = []

    rule {
        source_labels = ["__syslog_message_hostname"]
        target_label  = "host"
    }

    rule {
        source_labels = ["__syslog_message_hostname"]
        target_label  = "hostname"
    }

    rule {
        source_labels = ["__syslog_message_severity"]
        target_label  = "level"
    }

    rule {
        source_labels = ["__syslog_message_app_name"]
        target_label  = "application"
    }

    rule {
        source_labels = ["__syslog_message_facility"]
        target_label  = "facility"
    }

    rule {
        source_labels = ["__syslog_connection_hostname"]
        target_label  = "connection_hostname"
    }
}

# Syslog Source
loki.source.syslog "syslog" {
    listener {
        address      = "0.0.0.0:601"
        protocol     = "tcp"
        idle_timeout = "0s"
        use_rfc5424_message = true
        labels       = { job = "syslog", component = "loki.source.syslog", protocol = "tcp" }
        max_message_length = 0
    }
    listener {
        address      = "0.0.0.0:514"
        protocol     = "udp"
        idle_timeout = "0s"
        use_rfc5424_message = true
        labels       = { job = "syslog", component = "loki.source.syslog", protocol = "udp" }
        max_message_length = 0
    }
    forward_to    = [loki.write.syslog.receiver]
    relabel_rules = discovery.relabel.syslog.rules
}

# Loki Endpoint Configuration
loki.write "syslog" {
    endpoint {
        url = "https://loki.tld/loki/api/v1/push"
    }
}
