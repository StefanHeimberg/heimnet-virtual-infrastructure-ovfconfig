# This file describes the network interfaces available on your system
# For more information, see netplan(5).
network:
  version: 2
  renderer: networkd
  ethernets:
    %DEVICE%:
      dhcp: no
      addresses: [%ADDRESS%/%NETMASK%]
      gateway4: %GATEWAY%
      nameservers:
        search: [%SEARCH_DOMAIN%]
        addresses: [%NAMESERVER%]
