#!/bin/bash

# Get the computer hostname
HOSTNAME=$(hostname)

# Get the computer serial number
SERIAL=$(sudo dmidecode -s system-serial-number)

# Get the computer model
MODEL=$(sudo dmidecode -s system-product-name)

# Get the MAC address for enp1s0
MAC_ENP=$(ip link show enp1s0 | awk '/ether/ {print $2}')

# Get the MAC address for wlp2s0
MAC_WLP=$(ip link show wlp2s0 | awk '/ether/ {print $2}')

# Create a new text file with the hostname, serial number, MAC addresses, and computer model
echo "Hostname: $HOSTNAME" > "$HOSTNAME.txt"
echo "Serial Number: $SERIAL" >> "$HOSTNAME.txt"
echo "Computer Model: $MODEL" >> "$HOSTNAME.txt"
echo "MAC Address (enp1s0): $MAC_ENP" >> "$HOSTNAME.txt"
echo "MAC Address (wlp2s0): $MAC_WLP" >> "$HOSTNAME.txt"

# Move the file to the network drive
sudo mount -t cifs //10.1.204.8/DeezNotes /mnt -o username=USERNAME,password=PASSWORD
sudo mv "$HOSTNAME.txt" /mnt/MachineInfo/

# Open the text file in the default text editor
xdg-open "$HOSTNAME.txt"
