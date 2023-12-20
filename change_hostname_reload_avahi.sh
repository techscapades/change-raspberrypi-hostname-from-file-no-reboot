#!/bin/bash

set +e

CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
NEW_HOSTNAME=`cat /etc/new_hostname | tr -d " \t\n\r"`

echo `cat /etc/new_hostname | tr -d "\t\n\r"` >/etc/hostname
sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
echo `cat /etc/new_hostname | tr -d "\t\n\r"` >/proc/sys/kernel/hostname
systemctl restart avahi-daemon

exit 0
