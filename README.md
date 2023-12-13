# change-raspberrypi-hostname-from-text-file
A simple bash script that changes the hostname of the raspberrypi from the contents of a file, modified from this thread:
https://raspberrypi.stackexchange.com/questions/114400/how-to-set-the-hostname-via-boot-config-before-first-boot

Here's the bash script:
_
#!/bin/bash

set +e

CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
NEW_HOSTNAME=`cat /path_to_new_hostname_file | tr -d " \t\n\r"`

echo `cat /path_to_new_hostname_file | tr -d "\t\n\r"` >/etc/hostname
sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts

exit 0
_

you can add a 'reboot now' command to make the changes immediate
