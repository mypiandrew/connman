#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Create directories if they don't exist
#mkdir -p /usr/local/bin
#mkdir -p /etc/udev/rules.d

# Copy files to their respective locations
cp connman /usr/local/bin/
cp qmi-network-raw /usr/local/bin/
cp modemstat /usr/local/bin/
cp sim.conf /etc/
cp qmi-network.conf /etc/
cp 20-modem-ec2x.rules /etc/udev/rules.d/
cp 20-modem-7xxx.rules /etc/udev/rules.d/

# Set correct permissions
chmod 755 /usr/local/bin/connman
chmod 755 /usr/local/bin/qmi-network-raw
chmod 755 /usr/local/bin/modemstat
chmod 644 /etc/sim.conf
chmod 644 /etc/qmi-network.conf
chmod 644 /etc/udev/rules.d/20-modem-ec2x.rules
chmod 644 /etc/udev/rules.d/20-modem-7xxx.rules

# Reload udev rules
udevadm control --reload-rules

echo "Installation completed successfully."