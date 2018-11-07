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

### System

* **guestinfo.ovf_hostname** (Mandatory)\
  Hostname des Systems

### Adminuser

* **guestinfo.ovf_adminuser_name** (Mandatory)\
  Login id des Administration User

* **guestinfo.ovf_adminuser_password** (Mandatory)\
  Hashed Passwort des Administration User

  Hash Password: ```openssl passwd -1 -salt $(openssl -1 rand -base64 6) mypasswd123$```

* **guestinfo.ovf_adminuser_authorized_keys** (Mandatory)\
  Authorized SSH Keys des Administration User

### Network

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
