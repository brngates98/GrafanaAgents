This directory contains different agent configs for collecting SNMP 
Mimir - these agents are configured to send metrics to mimir

Prometheus - These agents are configured to send to prometheus 

Special note for prometheus you need the  --web.enable-remote-write-receiver flag enabled

Metrics:
The built-in snmp.yml for the grafana agent is:
https://github.com/grafana/agent/blob/main/pkg/integrations/snmp_exporter/common/snmp.yml


I have provided a few aswell

SNMP V3 IF-MIB:
https://github.com/brngates98/GrafanaAgents/tree/main/snmp/snmp_generators/snmpv3_if_mib/snmp.yml

SNMP V2 Public IF-MIB:
https://github.com/brngates98/GrafanaAgents/blob/main/snmp/snmp_generators/snmpv2_if_mib/snmp.yml

MerakiCLoud SNMPV2 MERAKI MIB:
https://github.com/brngates98/GrafanaAgents/blob/main/snmp/snmp_generators/meraki/snmp.yml