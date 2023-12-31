# change raspberrypi hostname from file no reboot
A simple bash script that changes the hostname of the raspberrypi from the contents of a file without the needing to reboot after, modified from this thread:
https://raspberrypi.stackexchange.com/questions/114400/how-to-set-the-hostname-via-boot-config-before-first-boot

# USE CASES
While you can always set the hostname when the image is burnt onto the SD card or using raspi-config, this process is slow
and its not efficient if you want to give hundreds of raspberrypis their own unique hostname without the need for a reboot 
, thus this script is for the process to be done more programmatically, ideally included in a greater bash script which sets up the pi and everything else.
Alternatively this script can be used to dynamically change the hostname when triggered through custom frontend software


I created a file called '/etc/new_hostname' to store the new hostname

Tested on my raspberrypi and everything works well.

# In case you're lost, here are the steps:

1. create the file: sudo nano /etc/new_hostname
   
(in the file, enter your hostname here, following the rules of setting hostnames on rpi, search it up)

then press ctrl + x, y, enter to exit the nano editor

2. create the bash script: sudo nano change_hostname.sh

(copy the bash script I included above into the file and change the path_to_new_hostname to /etc/new_hostname)

then press ctrl + x, y, enter to exit the nano editor

3. make the bash script executable: sudo chmod 777 change_hostname.sh

4. run the bash script: sudo bash change_hostname.sh

5. confirm the changes have been made:
   
     cat /etc/hosts
   
     cat /etc/hostname

     cat /proc/sys/kernel/hostname


6. if you have services you want to access from your_hostname.local,
   put systemctl restart avahi-daemon before exit 0 in the script and
   you'll have to wait a while before changes take place.
   I have uploaded the script for it already. You can append additional
   services that need to be reloaded with systemctl as well

# NOTES: 

the more adept among you will replace step 1 with:

   sudo echo your_new_hostname >/etc/new_hostname
