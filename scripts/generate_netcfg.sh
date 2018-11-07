#!/usr/bin/env bash

if [ -z "$1" ]; then
    (>&2 echo "ERROR: device parameter missing. use $0 <device> <address> <gateway> <nameserver> <searchdomain>")
    exit 1
fi

device=$1
address=$2
gateway=$3
nameserver=$4
searchdomain=$5

cat << EOF_NETCFG_HEADER
# This file describes the network interfaces available on your system
# For more information, see netplan(5).
network:
  version: 2
  renderer: networkd
  ethernets:
EOF_NETCFG_HEADER

echo "    $device:"

if [ ! -z "$address" ]; then
    echo "      dhcp4: no"
    echo "      addresses: [$address]"
    if [ ! -z "$gateway" ]; then
        echo "      gateway4: $gateway"
    fi
    if [ ! -z "$nameserver" ]; then
        echo "      nameservers:"
        if [ ! -z "$searchdomain" ]; then
            echo "        search: [$searchdomain]"
        fi
        echo "        addresses: [$nameserver]"
    fi
else
    echo "      dhcp4: yes"
fi
