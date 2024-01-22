# SNMP Monitoring with Grafana Agents


Step one: Install Grafana Agent: https://github.com/grafana/agent/releases

Step Two: Decide on what SNMP Protocol to use.
--------------------------------------------------
### We will focus on SNMPv3 using the if_mib to use SNMPv3 you will need to define a snmp.yml file, you can use the provided one as long as you update the auth parameters accordingly. 
https://github.com/brngates98/GrafanaAgents/blob/main/snmp/snmp_generators/snmpv3_if_mib/snmp.yml

#### i like to place snmp.yml in /etc/snmp.yml but it can go wherever as long as you define the location in the agent config file.

# Static Mode
Here is the grafana agent config template for static mode: https://github.com/brngates98/GrafanaAgents/blob/main/snmp/mimir/static/snmp/grafana-agent.yaml
# Flow Mode
Here is the grafana agent config template for flow mode: https://github.com/brngates98/GrafanaAgents/blob/main/snmp/mimir/flow/snmpv3/config.river


If you have any issues feel free to email me brian@briangates.tech
