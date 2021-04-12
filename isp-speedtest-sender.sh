#!/bin/bash
#
# Calls speedtest cli command and parses result to a more readable format
# {
#   "success": 1 (0 or 1)
#   "message": "No problems"
#   "host": "some.speedtest.server.com",
#   "latency": 123.4,
#   "download": 1234567.890,
#   "upload": 1234567.890
#  }
#

if [ "$#" -lt 3 ]; then
	echo "isp-speedtest-sender.sh requires minimum 3 arguments (server, port, host) speedtest server ID is an optional 4th argument"
	exit 1
fi

zabbix_server=$1
zabbix_port=$2
zabbix_host=$3
speedtest_server_id=$4

function zabbix_send {
	echo $1
	zabbix_sender --zabbix-server "${zabbix_server}" --port ${zabbix_port} --host "${zabbix_host}" --key net.isp.speedtest.results --value "$1" -vv
}

#
# Validate dependencies are installed
#
if ! [ -x "$(command -v zabbix_sender)" ]; then
  echo "zabbix_sender command not found"
  exit 1
fi

#
# Other dependency failures can be reported back to zabbix via the sender
#

if ! [ -x "$(command -v speedtest)" ]; then
  zabbix_send '{"success": 0, "message": "speedtest command not found"}'
  exit 1
fi

if ! [ -x "$(command -v jq)" ]; then
  zabbix_send '{"success": 0, "message": "jq command not found"}'
  exit 1
fi

#
# Perform speedtest and check exit code
#
if [ -z "$speedtest_server_id" ]; then
	SPEEDTEST_OUTPUT=$(speedtest --json 2>&1)
else
	SPEEDTEST_OUTPUT=$(speedtest --json --server ${speedtest_server_id} 2>&1)
fi

retVal=$?
if [ $retVal -ne 0 ]; then
  SPEEDTEST_OUTPUT=$(echo $SPEEDTEST_OUTPUT | sed 's/\"//g')
  zabbix_send "{\"success\": 0, \"message\": \"speedtest failure code [$retVal], output: [${SPEEDTEST_OUTPUT}]\", \"latency\": 0, \"download\": 0, \"upload\": 0, \"host\": null}"
  exit 1
fi

#
# Decode output json
#
echo $SPEEDTEST_OUTPUT
host=$(echo $SPEEDTEST_OUTPUT | jq -r '.server.host')
host_id=$(echo $SPEEDTEST_OUTPUT | jq -r '.server.id')
latency=$(echo $SPEEDTEST_OUTPUT | jq -r '.server.latency')
download=$(echo $SPEEDTEST_OUTPUT | jq -r '.download')
upload=$(echo $SPEEDTEST_OUTPUT | jq -r '.upload')

#
# Validate result fields
#
if [ -z "$host" ]; then
  zabbix_send '{"success": 0, "message": "Host not found in result"}'
  exit 1
fi

if [ -z "$latency" ]; then
  zabbix_send '{"success": 0, "message": "Latency not found in result"}'
  exit 1
fi

if [ -z "$download" ]; then
  zabbix_send '{"success": 0, "message": "Download not found in result"}'
  exit 1
fi

if [ -z "$upload" ]; then
  zabbix_send '{"success": 0, "message": "Upload not found in result"}'
  exit 1
fi


#
# Success
#
zabbix_send "{\"success\": 1, \"message\": \"no problem\", \"host\": \"$host\", \"server_id\": \"$host_id\", \"latency\": $latency, \"download\": $download, \"upload\": $upload}"
