# zabbix-speedtest.net
Zabbix template for calling https://www.speedtest.net and recording the results


## Dependencies
* [speedtest-cli](https://packages.ubuntu.com/search?keywords=speedtest-cli)
  * [speedtest-cli github](https://github.com/sivel/speedtest-cli)
* [jq](https://packages.ubuntu.com/disco/jq)

## Installation
* Install dependencies
* Copy the speedtest.sh to your Zabbix ExternalScripts location (default: /usr/lib/zabbix/externalscripts)
* Make sure the script permissions allow the zabbix server to execute them
* Import the template file into the Zabbix UI

## Setup and Configuration
* Link the template to the Zabbix Server host
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
