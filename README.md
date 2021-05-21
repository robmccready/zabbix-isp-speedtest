# zabbix-isp-speedtest
Zabbix template for monitoring ISP speeds using speedtest.net. 

To avoid timeouts when executing the speed test this template uses a combination of a trigger item and a trap item to asynchronously execute the speed test.

Latest version is v2.0.4 (2021-04-12). [Change Log](CHANGELOG.md)

## Limitations
* This template uses [External Checks](https://www.zabbix.com/documentation/2.2/manual/config/items/itemtypes/external) which are only supported on the Zabbix Server or a Proxy.

## Dependencies
* [speedtest-cli](https://github.com/sivel/speedtest-cli)
* [jq](https://github.com/stedolan/jq)
* [zabbix_sender](https://www.zabbix.com/documentation/current/manual/concepts/sender)
* atd job scheduler

## Installation (on a Zabbix Server)
* Install dependencies
* Copy isp-speedtest-trigger-atjob.sh and isp-speedtest-sender.sh to your Zabbix ExternalScripts location (default: /usr/lib/zabbix/externalscripts)
  * Ensure both scripts are executable by the Zabbix Agent user
* Copy userparameter_isp_speedtest.conf to the Zabbix Agent config folder (default: /etc/zabbix/zabbix_agentd.d)
  * Restart Zabbix Agent Service
* Import the template file into the Zabbix UI
* Link the template to the host

## Configuration

**Sender Macros**

The agent running the speedtest uses the zabbix sender to post the results back to the Zabbix server.

* **SPEEDTEST_SENDER_SERVER** (default: localhost): The hostname or IP address of the Zabbix server to send the results to

* **SPEEDTEST_SENDER_PORT** (default: 10051): The port of the Zabbix server

* **SPEEDTEST_SENDER_HOST** (default: Zabbix server): The host that the template is applied to so the sender can find the results item.

**Speedtest Macros**

Configure the execution of the speedtest runs

* **SPEEDTEST_UPDATE_INTERVAL** (default: 3h): How often to run the speedtest

* **SPEEDTEST_SERVER_ID** (default: blank): If filled in it will lock speedtest to a specific server (speedtest --list for available servers)

**Trigger Macros**

Configure trigger values for alerts

* **SPEEDTEST_TRIGGER_AVG_COUNT** (default: 3): Average values evaluated by triggers to prevent one bad run causing alerts

* **SPEEDTEST_TRIGGER_DOWNLOAD_LOW** (default: 100Mbps): Trigger when average download speeds fall below

* **SPEEDTEST_TRIGGER_UPLOAD_LOW** (default: 8Mbps): Trigger when average upload speeds fall below

* **SPEEDTEST_TRIGGER_LATENCY_HIGH** (default: 50ms): Trigger when average latency is above
  
## Template Items
* Speedtest Trigger (calls isp-speedtest-trigger-atjob script)
* Speedtest Results (trapper item - receives data from isp-speedtest-sender script)
  * Speedtest Download
  * Speedtest Upload
  * Speedtest Host (track which speedtest server gets used)
  * Speedtest Latency (rough latency to host)
  * Speedtest Success (boolean value if execution succeeded)
  * Speedtest Message (error message if any)

## Template Triggers
* Speedtest FAILED
* Download Speed LOW
* Upload Speed LOW
* Latency HIGH

## Template Graphs
* Download speed
* Upload speed
* Latency
* Summary graph with download, upload, and latency

The 3 individual graphs are included on a monitoring screen as well
