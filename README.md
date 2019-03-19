# zabbix-speedtest.net
Zabbix template for calling https://www.speedtest.net and recording the results


## Dependencies
* [speedtest-cli](https://packages.ubuntu.com/search?keywords=speedtest-cli)

## Installation
* Copy the speedtest.sh to your Zabbix ExternalScripts location (default: /usr/lib/zabbix/externalscripts)
* Make sure the script permissions allow the zabbix server to execute them
* Import the template file into the Zabbix UI

## Setup and Configuration
* Link the template to the Zabbix Server host
* Update the trigger macros if desired
  * {$TRIGGER_DOWNLOAD_LOW} default: 100MB
  * {$TRIGGER_UPLOAD_LOW}   default: 8MB

### Template Items
* Check Speed (3hr refresh)
  * Download Speed
  * Upload Speed
  * Latency
  * Host (track which speedtest server gets used)

### Template Triggers
* Download Speed LOW
* Upload Speed LOW

### Template Graphs
* Download speed
* Upload speed
* Latency

All 3 graphs are included on a monitoring screen as well
