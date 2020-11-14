#!/bin/sh
#

export SHELL="/bin/bash"
zbxhome="/usr/lib/zabbix/externalscripts"


#
# Validate dependencies are installed
#
if ! [ -x "$(command -v zabbix_sender)" ]; then
  echo "zabbix_sender command not found"
  exit 1
fi

if ! [ -x "$(command -v speedtest)" ]; then
  echo "speedtest command not found"
  exit 1
fi

if ! [ -x "$(command -v jq)" ]; then
  echo "jq command not found"
  exit 1
fi

if ! [ -x "$(command -v at)" ]; then
  echo "at command not found"
  exit 1
fi
  
cmd="${zbxhome}/isp-speedtest-sender.sh '$1' '$2' '$3' '$4'"  
echo "Scheduling(now): ${cmd}"
echo "${cmd}" | at now


