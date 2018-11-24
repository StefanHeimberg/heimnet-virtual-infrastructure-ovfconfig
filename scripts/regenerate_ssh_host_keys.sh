#!/usr/bin/env bash

echo "delete existing ssh host keys"
/bin/rm -vf /etc/ssh/ssh_host_*

echo "reconfigure server to generate new host keys"
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure openssh-server
