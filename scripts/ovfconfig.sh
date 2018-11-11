#!/usr/bin/env bash

set -e

readonly scriptDir=$(dirname "$(readlink -f "$0")")

# log stdout and stderror to logfile
exec >  >(tee -ia ~/ovfconfig.log)
exec 2> >(tee -ia ~/ovfconfig-error.log >&2)

echo "**** ovfconfig started at $(date +"%Y-%m-%d %H:%M:%S")"
(>&2 echo "**** ovfconfig started at $(date +"%Y-%m-%d %H:%M:%S")")

readonly prefix='guestinfo.heimnet'

function get_guestinfo() {
    local key=$1
    local value=$(vmtoolsd --cmd "info-get $prefix.${key}" 2> /dev/null || true)
    echo $value
}

# ---------------------------------------------------------
# Configure Hostname
# ---------------------------------------------------------

readonly gi_hostname=$(get_guestinfo "hostname")

echo "guestinfo property $prefix.hostname = ${gi_hostname}"

if [ -n "$gi_hostname" ]; then
    ${scriptDir}/configure_hostname.sh $gi_hostname
fi

# ---------------------------------------------------------
# Configure Admin User
# ---------------------------------------------------------

readonly gi_adminuser_name=$(get_guestinfo "adminuser_name")
readonly gi_adminuser_password_hash=$(get_guestinfo "adminuser_password_hash")
readonly gi_adminuser_authorized_keys=$(get_guestinfo "adminuser_authorized_keys")

echo "guestinfo property $prefix.adminuser_name = ${gi_adminuser_name}"
echo "guestinfo property $prefix.adminuser_password_hash = ${gi_adminuser_password_hash}"
echo "guestinfo property $prefix.adminuser_authorized_keys = ${gi_adminuser_authorized_keys}"

if [ -n "$gi_adminuser_name" ] && [ -n "$gi_adminuser_password_hash" ]; then
    ${scriptDir}/configure_adminuser.sh $gi_adminuser_name $gi_adminuser_password_hash $gi_adminuser_authorized_keys
fi

# ---------------------------------------------------------
# Configure Networking
# ---------------------------------------------------------

readonly gi_address=$(get_guestinfo "address")
readonly gi_gateway=$(get_guestinfo "gateway")
readonly gi_nameserver=$(get_guestinfo "nameserver")
readonly gi_searchdomain=$(get_guestinfo "searchdomain")

echo "guestinfo property $prefix.address = ${gi_address}"
echo "guestinfo property $prefix.gateway = ${gi_gateway}"
echo "guestinfo property $prefix.nameserver = ${gi_nameserver}"
echo "guestinfo property $prefix.searchdomain = ${gi_searchdomain}"

if [ -n "$gi_address" ] && [ -n "$gi_gateway" ] && [ -n "$gi_nameserver" ]; then
    ${scriptDir}/configure_netcfg.sh 'ens160' $gi_address $gi_gateway $gi_nameserver $gi_searchdomain
else
    ${scriptDir}/configure_netcfg.sh 'ens160'
fi
