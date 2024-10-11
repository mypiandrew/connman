# Modem Supervisor Script for RAW-IP Modems

This repository contains a supervisor script for managing RAW-IP modems, primarily designed for use with cellular networks.

## Included Files and Locations

- `/usr/local/bin/connman`
- `/usr/local/bin/qmi-network-raw`
- `/usr/local/bin/modemstat`
- `/etc/sim.conf`
- `/etc/qmi-network.conf`
- `/etc/udev/rules.d/20-modem-ec2x.rules`
- `/etc/udev/rules.d/20-modem-7xxx.rules`

## Usage

The main script is `connman.sh`, which can be used as follows:

```
Usage: /usr/local/bin/connman.sh {first-start|start|stop|restart|status|start-monitor|stop-monitor}
```

### Example: Starting the Connection

```bash
root@raspberrypi:/usr/local/bin# ./connman.sh start
2024-10-11 14:07:21 - ConnMan: Stopping wwan0 interface
2024-10-11 14:07:21 - ConnMan: wwan0 interface stopped
2024-10-11 14:07:22 - ConnMan: Signal strength - 20/32
2024-10-11 14:07:22 - ConnMan: Registered OK on network : REGISTERED-HOME
2024-10-11 14:07:22 - ConnMan: Network ID : vodafone UK  Mode : EDGE / GSM 900
2024-10-11 14:07:22 - ConnMan: Connecting To Cellular Network
...
2024-10-11 14:07:29 - ConnMan: Modem connection started successfully.
```

### Example: Starting the Monitor

```bash
oot@raspberrypi:/usr/local/bin# ./connman.sh start-monitor
2024-10-11 14:07:58 - ConnMan: Monitor process spawned succssfully PID 16541
 2024-10-11 14:08:00 - ConnMan: Running End-to-end transaction check (attempt 1/3)
2024-10-11 14:08:02 - ConnMan: End-to-end check successful
2024-10-11 14:08:02 - ConnMan: Network check AOK
root@raspberrypi:/usr/local/bin#
```

### Example: Stopping the Monitor

```bash
root@raspberrypi:/usr/local/bin# ./connman.sh stop-monitor
2024-10-11 14:08:22 - ConnMan: Monitor process stopped.
```

### Example: Stopping the Connection

```bash
root@raspberrypi:/usr/local/bin# ./connman.sh stop
2024-10-11 14:08:32 - ConnMan: Monitor is not running.
2024-10-11 14:08:32 - ConnMan: Disconnecting From Cellular Network
...
2024-10-11 14:08:40 - ConnMan: Modem connection stopped successfully.
```

## Features

- Connection management for RAW-IP modems
- Network registration and signal strength monitoring
- DHCP client for IP address acquisition
- End-to-end transaction checks
- Background connection monitoring process with automatic checks for network connection viability

## Configuration

The script uses configuration files located in `/etc/`:

- `sim.conf`: SIM card configuration
- `qmi-network.conf`: QMI network configuration

Make sure to configure these files according to your network requirements.
Edit variables at top of script for network check intervals
Can log to /var/log/connman.log

## Troubleshooting

If you encounter any issues, check the following:

1. Ensure all files are in their correct locations
2. Verify that the configuration files are properly set up
3. Check the system logs for any error messages

For further assistance, please open an issue in this repository.
