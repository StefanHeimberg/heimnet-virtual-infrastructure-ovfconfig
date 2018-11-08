#!/usr/bin/env bash

# usage: ./configure_adminuser.sh <login> <password_hashed> <authorized_keys>

set -e

if [ -z "$1" ]; then
    (>&2 echo "ERROR: name parameter missing. use $0 <login> <password_hashed> <authorized_keys>")
    exit 1
fi

if [ -z "$2" ]; then
    (>&2 echo "ERROR: password_hashed parameter missing. use $0 <login> <password_hashed> <authorized_keys>")
    exit 1
fi

name=$1
passwordHashed=$2
authorizedKeys=$3

adminUserId=1000

if id -un $adminUserId > /dev/null 2>&1; then
    echo "admin user exists"

    currentAdminUserName=$(id -un $adminUserId)

    echo "kill all processes of user $currentAdminUserName"
    pkill -u $currentAdminUserName || true

    echo "delete user $currentAdminUserName"
    userdel -r $currentAdminUserName
fi

echo "adding user $name"
useradd -u $adminUserId -c "System Administrator" -G sudo -m -s /bin/bash $name

echo "changing password for $name"
echo "${name}:${passwordHashed}" | chpasswd -e

if [ ! -z "$authorizedKeys" ]; then
    echo "adding ssh keys for $name"
    if [ ! -d "/home/$name/.ssh" ]; then
    mkdir -m 775 /home/$name/.ssh
    chown ${name}:${name} /home/$name/.ssh
    else
    chmod 755 /home/$name/.ssh
    fi

    echo "$authorizedKeys" | base64 --decode > /home/$name/.ssh/authorized_keys
    chmod 664 /home/$name/.ssh/authorized_keys
    chown -R ${name}:${name} /home/$name/.ssh
fi

echo "lock root user password"
passwd -l root