Did you know, You can use a grafana agent as a generic syslog server!!

Here is how to do it


Install a grafana agent in flow mode, and use the provided config.river in this folder.

Make sure to replace the loki url with youre own loki endpoint

# instructions on how to use a Grafana Agent as a Syslog Receiver

1. Install Grafana agent on a computer/server/vm or in Kubernetes.

2. Use the provided config.river to use the agent to accept syslog messages.

By default it is configured to use the default TCP/UDP ports for Syslog and 0.0.0.0 so any ip available to the system the agent is installed on.

3. Point youre server/app/whatever to the grafana agents ip address or hostname.

4. Ensure Loki is receiving logs by going to Explorer in grafana, and querying job = "syslog" and see if you are receiving logs.