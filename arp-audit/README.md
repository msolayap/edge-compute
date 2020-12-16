
# README

## ARP Audit

```
For Better experience look at this file at any of the [MARKDOWN viewer](https://dillinger.io)
```

### Requirements

* Convert the Dynamic ARP entries inside a given router to STATIC ones.
* Ensure ARP entries are in sync within the SITE routers.
    *  By doing symmetric difference of ARP output between each device within the SITE and generate necessary commands to execute in respective device)

### Install
```sh
tar -xzvf arp-audit-0.1.tar.gz
cd arp-sync
```
### Configure
#### CSV File with device data
copy the csv file (as generated from [houdini site](https://houdini.edg.centurylink.net/login/)). with device, site and other metadata. 
Rename the file to *site_devices.csv*
>For Mock Run - prepare the file accordingly and rename the file to mock_site_devices.csv. Please not lib/mock_data.exp to be prepared prior to configure and run in mock mode.

### Execute
```sh
cd <base location>/edge-compute/arp-audit/bin
expect ./arp-audit.exp
```
### Review/Monitor
#### Log file
To analyse log file (trace of what happened during script execution)
```sh
cd <base location/edge-compute/arp-audit/log/
tail -f ec_arp_audit.log  # OR   vim ec_arp_audit.log
```
#### Auto generated MOP files
The MOP files would be generated inside the "mop" directory in follwing hierarchy.
> mop/<TIMESTAMP>/<SITENAME>/<DEVICE>

* TIMESTAMP - date time of format "YYYY-MM-DDTHH:MM:SSUTC" 
* SITENAME - SITE corresponding to the device (from CSV file)
* DEVICE - Device name where the content of this file to be executed.  

### Contact

| Purpose | Contact|
|-------|---------|
| **TOOL owner** | Stephen J Akers



