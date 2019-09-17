# zabbix-isp-speedtest
Zabbix template for monitoring ISP speed using speedtest.net


## Dependencies
* [speedtest-cli](https://github.com/sivel/speedtest-cli)
* [jq](https://github.com/stedolan/jq)

## Installation (on a Zabbix Agent)
* Install dependencies
* Copy isp-speedtest.sh to your Zabbix ExternalScripts location (default: /usr/lib/zabbix/externalscripts)
  * Ensure isp-speedtest.sh is executable by the Zabbix Agent user
* Copy userparameter_isp_speedtest.conf to the Zabbix Agent config folder (default: /etc/zabbix/zabbix_agentd.d)
  * Restart Zabbix Agent Service
* Import the template file into the Zabbix UI

## Setup and Configuration
* Link the template to the Zabbix Agent host 
* Update the trigger macros if desired
  * {$SPEEDTEST_UPDATE_INTERVAL} default: 3h
  * {$TRIGGER_DOWNLOAD_LOW} default: 100Mbps
  * {$TRIGGER_UPLOAD_LOW}   default: 8Mbps

### Template Items
* Check Speed (3hr refresh default)
  * Speedtest Download
  * Speedtest Upload
  * Speedtest Host (track which speedtest server gets used)
  * Speedtest Latency (rough latency to host)
  * Speedtest Success (boolean value if execution succeeded)
  * Speedtest Message (error message if any)

### Template Triggers
* Speedtest FAILED
* Download Speed LOW
* Upload Speed LOW

### Template Graphs
* Download speed
* Upload speed
* Latency

All 3 graphs are included on a monitoring screen as well
