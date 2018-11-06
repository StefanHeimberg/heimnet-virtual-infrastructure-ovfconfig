#!/usr/bin/env bash

set -e

scriptDir=$(dirname "$(readlink -f "$0")")
netCfgFile=/etc/netplan/01-netcfg.yaml

$scriptDir/generate_netcfg.sh $1 $2 $3 $4 $5 > $netCfgFile

netplan apply