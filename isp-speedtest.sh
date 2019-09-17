#!/bin/sh
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


#
# Validate dependencies are installed
#
if ! [ -x "$(command -v speedtest)" ]; then
  echo '{"success": 0, "message": "speedtest command not found"}'
  exit 1
fi

if ! [ -x "$(command -v jq)" ]; then
  echo '{"success": 0, "message": "jq command not found"}'
  exit 1
fi

#
# Perform speedtest and check exit code
#
SPEEDTEST_OUTPUT=$(speedtest --json)
retVal=$?
if [ $retVal -ne 0 ]; then
  echo '{"success": 0, "message": "speedtest failure code: '$retVal'"}'
  exit 1
fi

#
# Decode output json
#
host=$(echo $SPEEDTEST_OUTPUT | jq -r '.server.host')
latency=$(echo $SPEEDTEST_OUTPUT | jq -r '.server.latency')
download=$(echo $SPEEDTEST_OUTPUT | jq -r '.download')
upload=$(echo $SPEEDTEST_OUTPUT | jq -r '.upload')

#
# Validate result fields
#
if [ -z "$host" ]; then
  echo '{"success": 0, "message": "Host not found in result"}'
  exit 1
fi

if [ -z "$latency" ]; then
  echo '{"success": 0, "message": "Latency not found in result"}'
  exit 1
fi

if [ -z "$download" ]; then
  echo '{"success": 0, "message": "Download not found in result"}'
  exit 1
fi

if [ -z "$upload" ]; then
  echo '{"success": 0, "message": "Upload not found in result"}'
  exit 1
fi


#
# Success
#
echo '{"success": 1, "message": "no problem", "host": "'$host'", "latency": '$latency', "download": '$download', "upload": '$upload'}'
