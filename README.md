# Modem Supervisor Script for RAW-IP Modems

This repository contains a cellular network connection supervisor script for Raspberry Pi mPCIe modems 

## Included Files and Locations

- `/usr/local/bin/connman`
- `/usr/local/bin/qmi-network-raw`
- `/usr/local/bin/modemstat`
- `/etc/sim.conf`
- `/usr/local/bin/softresetmodem.sh`
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
Loading profile at /etc/qmi-network.conf...
    APN: pp.vodafone.co.uk
    APN user: unset
    APN password: unset
    qmi-proxy: no
Starting network with 'qmicli -d /dev/cdc-wdm0 --device-open-net=net-raw-ip|net-no-qos-header --wds-start-network=apn='pp.vodafone.co.uk',ip-type=4  --client-no-release-cid '...
Saving state at /tmp/qmi-network-state-cdc-wdm0... (CID: 20)
Saving state at /tmp/qmi-network-state-cdc-wdm0... (PDH: 2267975568)
Network started successfully
2024-10-11 14:07:28 - ConnMan: Modem Connected OK
udhcpc: started, v1.30.1
udhcpc: sending discover
udhcpc: sending select for 10.118.57.75
udhcpc: lease of 10.118.57.75 obtained, lease time 7200
2024-10-11 14:07:29 - ConnMan: Modem connection started successfully.
```

### Example: Starting the Monitor

```bash
root@raspberrypi:/usr/local/bin# ./connman.sh start-monitor
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
Loading profile at /etc/qmi-network.conf...
    APN: pp.vodafone.co.uk
    APN user: unset
    APN password: unset
    qmi-proxy: no
Loading previous state from /tmp/qmi-network-state-cdc-wdm0...
    Previous CID: 20
    Previous PDH: 2267975568
Stopping network with 'qmicli -d /dev/cdc-wdm0 --wds-stop-network=2267975568 --client-cid=20 '...
Network stopped successfully
Clearing state at /tmp/qmi-network-state-cdc-wdm0...
2024-10-11 14:08:38 - ConnMan: Modem Disconnected OK
2024-10-11 14:08:38 - ConnMan: Stopping wwan0 interface
2024-10-11 14:08:38 - ConnMan: Terminating udhcpc process for wwan0 (PID: 16529)
2024-10-11 14:08:40 - ConnMan: wwan0 interface stopped
2024-10-11 14:08:40 - ConnMan: Modem connection stopped successfully.
```

## Features

- Connection management for SIMCOM/QUECTEL RAW-IP modems (e.g. SIM7600, EG25-G EC21-G EC25-E)
- Network registration and signal strength monitoring
- UDHCP client for automatic RAW IP address acquisition
- Background connection monitoring process with automatic End-to-end checks for network connection viability

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
