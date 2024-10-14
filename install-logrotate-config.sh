#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Define the logrotate configuration
read -r -d '' LOGROTATE_CONFIG << EOM
/var/log/connman.log {
    size 1M
    copytruncate
    rotate 1
    maxlines 20
    missingok
    notifempty
    compress
    delaycompress
}
EOM

# Define the path for the logrotate configuration file
LOGROTATE_FILE="/etc/logrotate.d/connman"

# Create the logrotate configuration file
echo "$LOGROTATE_CONFIG" > "$LOGROTATE_FILE"

# Set correct permissions
chmod 644 "$LOGROTATE_FILE"

echo "Logrotate configuration for connman has been installed to $LOGROTATE_FILE"

# Test the configuration
echo "Testing the logrotate configuration..."
logrotate -d "$LOGROTATE_FILE"

echo "Installation complete. Please review any messages above to ensure there are no issues."