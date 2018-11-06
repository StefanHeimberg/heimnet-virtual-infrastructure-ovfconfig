# Heimnet OVFConfig

## Requirements

- VMWare ESXi 6.7 VM
- Ubuntu 18.04 LTS

## Installation

Checkout Git Repository and log in as **root**

```
root@ubuntu:~# git clone http://nas.heimnet.ch:10080/Heimnet/heimnet-ovfconfig.git
root@ubuntu:~# cd heimnet-ovfconfig
root@ubuntu:~/heimnet-ovfconfig# ./install.sh
```

## Guestinfo Properties

* **guestinfo.ovf_hostname** (Mandatory)\
  Hostname des Systems

* **guestinfo.ovf_address** (Optional)\
  IP Adresse in der CIDR Notation falls DHCP nicht verwendet wird.

Wenn **guestinfo.ovf_address not ""** dann:

* **guestinfo.ovf_domain** (Mandatory)\
  Domain Name des Systems.

* **guestinfo.ovf_gateway** (Mandatory)\
  Standard Gateway für Routing

* **guestinfo.ovf_nameserver** (Mandatory)\
  Standard Nameserver für Namensauflösung

* **guestinfo.ovf_ntpserver** (Mandatory)\
  Standard Zeitserver für Zeitsynchronisierung