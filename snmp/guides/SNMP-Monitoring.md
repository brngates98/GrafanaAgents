Universal Guide: Using SNMP with Grafana Agents for Mimir and Prometheus

Hey everyone! I've put together a universal guide for using SNMP with Grafana Agents, compatible with both Mimir and Prometheus. Please note that this guide is specifically for SNMP V2 and uses the community string 'public'.
 It won't cover the process of enabling SNMP on your network device.
 
Step 1: Install Grafana Agent
Step 2: Choose Your Monitoring Tool
Prometheus Guide:
To send metrics to Prometheus, ensure that you have defined --web.enable-remote-write-receiver.
Since you already have the agent installed, you can select between two modes: Static and Flow.
Static Mode:
- Configuration File: Static SNMP Configuration
- Modify the following settings:
 - Change http://prometheus/api/v1/writeto your Prometheus IP:Port or hostname.
 - Adjust SNMP targets to match your devices.
Flow Mode:
- Configuration File: Flow SNMP Configuration
- Modify the following settings:
 - Change http://prometheus/api/v1/writeto your Prometheus IP:Port or hostname.
 - Adjust SNMP targets to match your devices.
Mimir Guide:
Using Mimir is straightforward, and you won't need any extra feature flags.
Static Mode:
- Configuration File: Static SNMP Configuration
Flow Mode:
- Configuration File: Flow SNMP Configuration
I've successfully tested this setup against various devices, including opnsense, pfsense, Cisco 2960/3560X switches.
Happy monitoring! 😊