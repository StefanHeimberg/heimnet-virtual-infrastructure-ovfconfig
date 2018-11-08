#!/usr/bin/env bash

echo "*************** start test"

./scripts/configure_adminuser.sh \
        sysadmin \
        $(openssl passwd -1 -salt $(openssl rand -base64 6) mypasswd345$) \
        c3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBREFRQUJBQUFCQVFEWTBTeW8xS3Zqb3pTcTlidktlcktrMTVmOFNsNzhWcW9VdzZnbW04UnFRbDRlajhWNWdRaFFabnk3NURXZi9iS3c3akZzd0l5bHRoK3ExZUpkOUtoYjY3LzBacjFoalNLU1B0YkhDNkJEdDl1RFdrdVJjNG00VW1YUXlTdEpMa0ZucW13Nk5YbVZBTlcvT3hqcVpvYUxUMnZRc0IybHRORzFvSU4yKzFqNGhUQS9ZUWUxOUZqcmcyVnJWYllkSHJqNzM1Qy9OQ0NkWnhBbmlCS3FPOVFDUlc0NDdMNVFqRDZhSVYyRkNiQ1Y3YXNOWFpTS29kZW1wZWdDV0c5Z0ZDbGZlTjIvaFE1b0xBVmtITXN0WEthNS9hQ1NhWFhGVEF6K1dFY0JrZ0h1TXp2NDNxUXROL25veW96ak9mNmZmc2JWeWVPbFFLY2JOMTFmN3doQVdpSzMga29udGFrdEBzdGVmYW5oZWltYmVyZy5jaAo=

echo "*************** finished test"

passwd -u root