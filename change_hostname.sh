#!/bin/bash

set +e

CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
NEW_HOSTNAME=`cat /path_to_new_hostname_file | tr -d " \t\n\r"`

echo `cat /path_to_new_hostname_file | tr -d "\t\n\r"` >/etc/hostname
sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts

exit 0
