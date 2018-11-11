# Heimnet OVFConfig
​
## Requirements
​
- VMWare ESXi 6.7 VM
- Ubuntu 18.04 LTS
​
## Installation
​
Checkout Git Repository and log in as **root**
​
```
root@ubuntu:~# git clone http://nas.heimnet.ch:10080/Heimnet/heimnet-ovfconfig.git
root@ubuntu:~# cd heimnet-ovfconfig
root@ubuntu:~/heimnet-ovfconfig# ./install.sh
```
​
## Guestinfo Properties
​
### System
​
**guestinfo.heimnet.hostname** (Mandatory)
​
  Hostname des Systems
​
### Adminuser
​
**guestinfo.heimnet.adminuser_name** (Mandatory)
​
  Login id des Administration User
​
**guestinfo.heimnet.adminuser_password_hash** (Mandatory
​
  Hashed Passwort des Administration User
​
  Hash Password: ```openssl passwd -1 -salt $(openssl rand -base64 6) mypasswd123$```
​
**guestinfo.heimnet.adminuser_authorized_keys** (Mandatory)
​
  Authorized SSH Keys des Administration User
​
### Network
​
**guestinfo.heimnet.address** (Optional)
​
  IP Adresse in der CIDR Notation falls DHCP nicht verwendet wird.
​
Wenn **guestinfo.heimnet.address not ""** dann:
​
**guestinfo.heimnet.gateway** (Mandatory
​
  Standard Gateway für Routing
​
**guestinfo.heimnet.nameserver** (Mandatory)
​
  Standard Nameserver für Namensauflösung
​
**guestinfo.heimnet.searchdomain** (Mandatory)
​
  Standard searchdomain für Namensauflösung
​
### Links
​
- https://www.virtuallyghetto.com/2011/01/how-to-extract-host-information-from.html