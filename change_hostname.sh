#!/bin/bash

# Define the expected file path
file_path="/cam_name"

# Check if the file exists at root
if [ -f "$file_path" ]; then
    # Read the value from the file
    value=$(< "$file_path")
    echo "The value from $file_path is: $value"
else
    echo "Error: File $file_path does not exist at root!"
    exit 1
fi


echo "The value from the cam_name file is: $value"
echo "changing hostname to $value.local"
echo "$value" | tee /etc/new_hostname.txt > /dev/null

set +e

CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
NEW_HOSTNAME=`cat /etc/new_hostname.txt | tr -d " \t\n\r"`

echo `cat /etc/new_hostname.txt | tr -d "\t\n\r"` >/etc/hostname
sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
echo `cat /etc/new_hostname.txt | tr -d "\t\n\r"` >/proc/sys/kernel/hostname

exit 0

