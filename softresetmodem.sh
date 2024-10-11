#!/bin/bash

# Function to check if the modem is connected
check_modem_connected() {
    lsusb -t | grep -q 'Driver=option\|Driver=qmi_wwan'
}

# Function to check if AT commands work
check_modem_at_command_works() {
    chat -Vs TIMEOUT 1 ECHO OFF "" "AT+GSN" "OK" >/dev/modemAT </dev/modemAT 2>/tmp/log
    REGEX='^([0-9]+)$'
    RESPONSE=$(cat /tmp/log | head -n -1 | tail -n +2 | grep -v '^[[:space:]]*$')
    if [[ $RESPONSE =~ $REGEX ]]; then
        return 0
    fi
    return 1
}

# Function to reset the modem
reset_modem() {
    chat -Vs TIMEOUT 1 ECHO OFF "" "AT+CFUN=1,1" "OK" >/dev/modemAT </dev/modemAT
}

# Main script
echo "Checking modem is connected ..."
if ! check_modem_connected; then
    echo "Modem not detected initially. Please check the connection."
    exit 1
fi

echo "Checking modem AT commands work..."

if check_modem_at_command_works; then
	echo "Resetting modem using AT commands..."
	reset_modem
else
	echo "Resetting modem using hardware line commands..."
    echo 1 >/dev/mpcie-reset
	sleep 2
	echo 0 >/dev/mpcie-reset	
fi

echo "Waiting for modem to disconnect..."
while check_modem_connected; do
    sleep 1
done
echo "Modem disconnected."

echo "Waiting for modem to reconnect..."
timeout=30
counter=0
while ! check_modem_connected; do
    sleep 1
    ((counter++))
    if [ $counter -ge $timeout ]; then
        echo "Timeout: Modem did not reconnect within $timeout seconds."
        exit 1
    fi
done

echo "Modem reconnected successfully."
exit 0
