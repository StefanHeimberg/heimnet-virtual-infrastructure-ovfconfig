#!/usr/bin/env bash

echo "delete existing ssh host keys"
/bin/rm -vf /etc/ssh/ssh_host_*

echo "reconfigure server to generate new host keys"
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure openssh-server

echo "restart ssh server"
if systemctl is-active --quiet ssh; then
    echo "ssh is active. restart ssh to activate settings"
    #systemctl restart ssh
else
    echo "ssh is not active. do not restrat ssh"
fi
