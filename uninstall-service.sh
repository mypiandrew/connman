#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Define the service file path
SERVICE_FILE="/etc/systemd/system/connman.service"

# Stop the service if it's running
systemctl stop connman.service

# Disable the service
systemctl disable connman.service

# Remove the service file
if [ -f "$SERVICE_FILE" ]; then
    rm "$SERVICE_FILE"
    echo "Connman service file removed."
else
    echo "Connman service file not found."
fi

# Reload systemd to recognize the changes
systemctl daemon-reload

echo "Connman service has been stopped, disabled, and removed."