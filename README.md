# change raspberrypi hostname from file no reboot
A simple bash script that changes the hostname of the raspberrypi from the contents of a file, modified from this thread:
https://raspberrypi.stackexchange.com/questions/114400/how-to-set-the-hostname-via-boot-config-before-first-boot

# USE CASES
While you can always set the hostname when the image is burnt onto the SD card or using raspi-config, this process is slow
and its not efficient if you want to give hundreds of raspberrypis their own unique hostname without the nees for a reboot , thus this script is for the 
process to be done more programmatically, ideally included in a greater bash script which sets up the pi and everything else.
Alternatively this script can be used to dynamically change the hostname when triggered through custom frontend software

Here's the bash script:

#!/bin/bash

set +e

CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`

NEW_HOSTNAME=`cat /path_to_new_hostname_file | tr -d " \t\n\r"`

echo `cat /path_to_new_hostname_file | tr -d "\t\n\r"` >/etc/hostname

sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts

echo `cat /etc/new_hostname | tr -d "\t\n\r"` >/proc/sys/kernel/hostname

exit 0


you can add a 'reboot now' command to make the changes immediate
I created a file called '/etc/new_hostname' to store the new hostname
Tested on my raspberrypi and everything works well.

# In case you're lost, here are the steps:

1. create the file: sudo nano /etc/new_hostname
   
(in the file, enter your hostname here, following the rules of setting hostnames on rpi, search it up)

then press ctrl + x, y, enter to exit the nano editor

2. create the bash script: sudo nano change_hostname.sh

(copy the bash script I included above into the file and change the path_to_new_hostname to /etc/new_hostname)

#!/bin/bash

set +e

CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`

NEW_HOSTNAME=`cat /etc/new_hostname | tr -d " \t\n\r"`

echo `cat /etc/new_hostname | tr -d "\t\n\r"` >/etc/hostname

sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts

echo `cat /etc/new_hostname | tr -d "\t\n\r"` >/proc/sys/kernel/hostname

exit 0

then press ctrl + x, y, enter to exit the nano editor

3. make the bash script executable: sudo chmod 777 change_hostname.sh

4. run the bash script: sudo bash change_hostname.sh

5. confirm the changes have been made:
   
     cat /etc/hosts
   
     cat /etc/hostname

     cat /proc/sys/kernel/hostname

7. Reboot your raspberrypi for changes to take place

8. the more adept among you will replace step 1 with:

   sudo echo your_new_hostname >/etc/new_hostname
