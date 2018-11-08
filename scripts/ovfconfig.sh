#!/usr/bin/env bash

set -e

readonly scriptDir=$(dirname "$(readlink -f "$0")")

# log stdout and stderro to logfile
exec >  >(tee -ia ~/ovfconfig.log)
exec 2> >(tee -ia ~/ovfconfig-error.log >&2)

function get_guestinfo() {
    local key=$1
    local value=$(vmtoolsd --cmd "info-get guestinfo.heimnet.${key}" 2> /dev/null || true)
    echo $value
}

#https://www.virtuallyghetto.com/2011/01/how-to-extract-host-information-from.html

# ---------------------------------------------------------
# Configure Hostname
# ---------------------------------------------------------

readonly gi_hostname=$(get_guestinfo "hostname")
echo "guestinfo property hostname = ${gi_hostname}"

if [ -n "$gi_hostname" ]; then
    ${scriptDir}/configure_hostname.sh $gi_hostname
fi


# ---------------------------------------------------------
# Configure Admin User
# ---------------------------------------------------------

readonly gi_adminuser_name=$(get_guestinfo "adminuser_name")
readonly gi_adminuser_password_hash=$(get_guestinfo "adminuser_password_hash")
readonly gi_adminuser_authorized_keys=$(get_guestinfo "adminuser_authorized_keys")

echo "guestinfo property adminuser_name = ${gi_adminuser_name}"
echo "guestinfo property adminuser_password_hash = ${gi_adminuser_password_hash}"
echo "guestinfo property adminuser_authorized_keys = ${gi_adminuser_authorized_keys}"

if [ -n "$gi_adminuser_name" ] && [ -n "$gi_adminuser_password_hash"]; then
    ${scriptDir}/configure_adminuser.sh $gi_adminuser_name $gi_adminuser_password_hash $gi_adminuser_authorized_keys
fi
