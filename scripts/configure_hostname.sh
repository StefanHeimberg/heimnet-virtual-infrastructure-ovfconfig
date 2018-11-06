#!/usr/bin/env bash

set -e

if [ -z "$1" ]; then
    (>&2 echo "ERROR: hostname parameter missing. use $0 <hostname>")
    exit 1
fi

oldHostname=$(hostname)
newHostname=$1

if [ "$oldHostname" != "$newHostname" ]; then
    hostname $newHostname
fi

changedHostname=$(hostname)
if [ "$changedHostname" != "$newHostname" ]; then
    (>&2 echo "ERROR: hostname not configured correctly")
    exit 1
fi

echo "$newHostname" > /etc/hostname
