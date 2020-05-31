#!/bin/bash
# run nmap against a set of ips inside hosts.txt 
# 3328 ports --> https://nmap.org/book/performance-port-selection.html
#   nmap -sS -Pn -A --top-ports 3328 -oA synscan_${NAME}-${INFOTEXT}_top_3328_ports_aggressive -iL hosts.txt
# scan all ports aggressive - set min-hostgroup to 256
# treat all hosts as up

if [ "$#" -ne 1 ]
then
  echo "Usage: ./auto-scan.sh INFOTEXT"
  exit 1
fi

INFOTEXT=$1
NAME=''

if [ -z "$NAME" ]
then
    echo "No Name set!"
    exit 1
fi

nmap -sS -Pn -A -vvv -p 1-65535 --min-hostgroup 256 -T4 -oA synscan_${NAME}-${INFOTEXT}_all_ports_aggressive -iL hosts.txt
