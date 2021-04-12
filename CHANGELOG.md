# zabbix-speedtest.net change log

## v2.0.4 - 2021-04-12
* Escape quotes in error message passed back to zabbix. Handles odd issue with recent (now fixed) bug in speedtest-cli [Handle case where ignoreids is empty or contains empty ids](https://github.com/sivel/speedtest-cli/commit/cadc68b5aef20f28648072cf07a8f155639b81dd)

## v2.0.3 - 2020-11-11
* Rename All-In-One report to "Speedtest Summary"
 * Update graph colors and summary graph to be cleaner
* Add high latency trigger (default 50ms)
* Increase Trend Histories to 750d to allow year on year comparison
* Add macros for configuring zabbix server/port for sender


## v2.0.0 - 2020-10-30
Scripts refactored to leverage atd and zabbix_sender to disconnect the execution of the speedtest from the zabbix maximum timeout of 30 seconds.[Escaping timeouts with atd](https://zabbix.org/wiki/Escaping_timeouts_with_atd)
* Add trigger script isp-speedtest-trigger-atjob.sh
* Refactor (and rename) speedtest script to use zabbix_sender: isp-speedtest-sender.sh
* Add support for specified speedtest server ID (speedtest --server <ID>)
* Add all-in-one report with download, upload, and latency
* Reskinned graphs to use speedtest.net download (greenish) and upload (purplish) colors


## v1.1.0 - 2019-09-18
* Convert from External Check to Zabbix Agent execution
* Rename items to net.isp.speedtest prefix
* Rename some files

## v1.0.0 - 2019-09-17
* Updated item names and descriptions
* Made execution script handle missing dependencies, execution errors, parsing results and returning a simplified JSON object which includes error info (if any)

