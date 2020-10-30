# zabbix-isp-speedtest
Zabbix template for monitoring ISP speed using speedtest.net


## Dependencies
* [speedtest-cli](https://github.com/sivel/speedtest-cli)
* [jq](https://github.com/stedolan/jq)
* atd job scheduler
* [zabbix_sender](https://www.zabbix.com/documentation/current/manual/concepts/sender)


## Installation (on a Zabbix Agent)
* Install dependencies
* Copy isp-speedtest-trigger-atjob.sh and isp-speedtest-sender.sh to your Zabbix ExternalScripts location (default: /usr/lib/zabbix/externalscripts)
  * Ensure both scripts are executable by the Zabbix Agent user
* Copy userparameter_isp_speedtest.conf to the Zabbix Agent config folder (default: /etc/zabbix/zabbix_agentd.d)
  * Restart Zabbix Agent Service
* Import the template file into the Zabbix UI

## Setup and Configuration
* Link the template to the Zabbix Agent host 
* Update the templace macros if needed
  * {$SPEEDTEST_SENDER_HOST} default: Zabbix server - replace with name of the host the template is applied to
  * {$SPEEDTEST_SERVER_ID} default: blank - fill in to lock speedtest to a specific server (speedtest --list for available servers)
  * {$SPEEDTEST_UPDATE_INTERVAL} default: 3h
  * {$TRIGGER_DOWNLOAD_LOW} default: 100Mbps
  * {$TRIGGER_UPLOAD_LOW} default: 8Mbps
  * {$SPEEDTEST_TRIGGER_AVG_COUNT} default: 3

### Template Items
* Speedtest Trigger (3hr refresh default - calls isp-speedtest-trigger-atjob.sh)
* Speedtest Results (trapper item - recieves data from isp-speedtest-sender.sh)
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
* All-in-one graph with download, upload, and latency

All 3 graphs are included on a monitoring screen as well
