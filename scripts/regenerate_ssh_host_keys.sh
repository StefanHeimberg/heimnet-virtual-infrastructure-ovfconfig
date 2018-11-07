#!/usr/bin/env bash

echo "delete existing ssh host keys"
/bin/rm -v /etc/ssh/ssh_host_*

echo "reconfigure server to generate new host keys"
dpkg-reconfigure openssh-server

echo "restart ssh server"
sudo systemctl restart ssh
