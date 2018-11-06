#!/usr/bin/env bash

_dir=$(dirname "$(readlink -f "$0")")
cd $_dir

login=$1
password=$2
authorizedKey=$3

echo "kill all processes of user $login"
killall -u $login

echo "delete user $login"
userdel -r $(id -un 1001)

set -e

echo "adding user $login"
useradd -u 1001 -c "System Administrator" -G sudo -m -s /bin/bash $login 

echo "changing password for $login"
echo "${login}:${password}" | chpasswd

if [ ! -d "/home/$login/.ssh" ]; then
  mkdir -m 775 /home/$login/.ssh
  chown ${login}:${login} /home/$login/.ssh
else
  chmod 755 /home/$login/.ssh
fi
echo "$authorizedKey" > /home/$login/.ssh/authorized_keys
chmod 664 /home/$login/.ssh/authorized_keys
chown -R ${login}:${login} /home/$login/.ssh

