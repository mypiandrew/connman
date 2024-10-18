#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Define the service file path
SERVICE_FILE="/etc/systemd/system/connman.service"

# Create the service file
cat > "$SERVICE_FILE" << EOL
[Unit]
Description=Connman Start and Monitor Service
After=network.target network-online.target systemd-networkd.service systemd-resolved.service
Wants=network-online.target
ConditionPathExists=/usr/local/bin/connman

[Service]
Type=simple
ExecStart=/bin/bash -c '/usr/local/bin/connman first-start || /usr/local/bin/connman start-monitor'
ExecStop=/usr/local/bin/connman stop

[Install]
WantedBy=multi-user.target
EOL

# Set proper permissions for the service file
chmod 644 "$SERVICE_FILE"

# Reload systemd to recognize the new service
systemctl daemon-reload

# Enable the service to start on boot
systemctl enable connman.service

# Start the service
systemctl start connman.service

echo "Connman service has been installed, enabled, and started."
