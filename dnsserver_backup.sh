#!/bin/bash
h=/home/yhxy/data/backup_data/dns/dns_1.4
s=`date +'%F'`
if [ ! -d "$h/$s" ]
then
    mkdir -p $h/$s
fi
scp -r -i /home/yhxy/70.pem root@192.168.1.4:/etc/named.conf $h/$s
scp -r -i /home/yhxy/70.pem root@192.168.1.4:/etc/named.conf.rpmnew $h/$s
scp -r -i /home/yhxy/70.pem root@192.168.1.4:/etc/named.iscdlv.key $h/$s
scp -r -i /home/yhxy/70.pem root@192.168.1.4:/etc/named.rfc1912.zones $h/$s
scp -r -i /home/yhxy/70.pem root@192.168.1.4:/etc/named.root.key $h/$s