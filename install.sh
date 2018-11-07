#!/usr/bin/env bash

scriptDir=$(dirname "$(readlink -f "$0")")

rm -f /etc/systemd/system/ovfconfig.service
cp -vf $scriptDir/systemd/ovfconfig.service /etc/systemd/system/ovfconfig.service

systemctl daemon-reload
systemctl enable ovfconfig.service