#!/usr/bin/env bash

# usage: ./configure_adminuser.sh <login> <password_hashed> <authorized_keys>

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

echo "... admin user:"

if id -un $adminUserId > /dev/null 2>&1; then
    echo "admin user exists"

    currentAdminUserName=$(id -un $adminUserId)

    if [ "$currentAdminUserName" = "$name" ]; then
        echo "admin user name match"
    else
        echo "admin user name does not match"

        echo "kill all processes of user $currentAdminUserName"
        pkill -u $currentAdminUserName || true

        echo "delete user $currentAdminUserName"
        userdel $currentAdminUserName

        echo "adding user $name"
        useradd -u $adminUserId -c "System Administrator" -G sudo -m -s /bin/bash $name
    fi
fi

echo "... admin password:"

if [ ! -z "$passwordHashed" ]; then
    echo "changing password for $name"
    echo "${name}:${passwordHashed}" | chpasswd -e
fi

echo "... admin ssh keys:"

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

    echo "deny ssh access with password authentication"
    sed --in-place 's|PermitRootLogin yes|PermitRootLogin no|g' /etc/ssh/sshd_config
    sed --in-place 's|#PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/sshd_config

    echo "restart ssh server"
    if systemctl is-active --quiet ssh; then
        echo "ssh is active. restart ssh to activate settings"
        #systemctl restart ssh
    else
        echo "ssh is not active. do not restrat ssh"
    fi
fi
