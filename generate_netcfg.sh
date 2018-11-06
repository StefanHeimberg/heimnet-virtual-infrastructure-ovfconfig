#!/usr/bin/env bash

# example: ./generate_netcfg.sh ens160 192.168.101.99 24 192.168.101.254 heimnet.ch 192.168.101.254

set -e

scriptDir=$(dirname "$(readlink -f "$0")")
templatesDir=$scriptDir/templates

device=$1
address=$2
netmask=$3
gateway=$4
searchDomain=$5
nameserver=$6

sed -e "s;%DEVICE%;$device;g" \
    -e "s;%ADDRESS%;$address;g" \
    -e "s;%NETMASK%;$netmask;g" \
    -e "s;%GATEWAY%;$gateway;g" \
    -e "s;%SEARCH_DOMAIN%;$searchDomain;g" \
    -e "s;%NAMESERVER%;$nameserver;g" $templatesDir/netcfg.yaml.tpl
