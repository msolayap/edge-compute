
# README

## ARP Audit

For Better experience look this file in any of the [MARKDOWN viewer](https://dillinger.io)

### Requirements

* Convert the Dynamic ARP entries inside a given router to STATIC ones.
* Ensure ARP entries are in sync within the SITE routers.
    *  By doing symmetric difference of ARP output between each device within the SITE and generate necessary commands to execute in respective device)

### Install
```sh
tar -xzvf arp-audit-0.x.tar.gz
cd arp-sync
```
### Configure
#### CSV File with device data
SITE and device details gets pulled from Houdini API (as generated from [houdini site](https://houdini.edg.centurylink.net/login/)). Each execution of the main script i.e arp-audit.exp contact the API service at the beginning and generate the *site_devices.csv* for further processing. 

>If you want to disable API fetching for device data and only expect the script to work on local copy of data (i.e site_devices.csv), set 0 to config value
*fetch_site_data_from_api*

### Execute
```sh
cd base location/edge-compute/arp-audit/bin
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
> mop/TIMESTAMP/SITENAME/DEVICE

* TIMESTAMP - date time of format "YYYY-MM-DDTHH:MM:SSUTC" 
* SITENAME - SITE corresponding to the device (from CSV file)
* DEVICE - Device name where the content of this file to be executed.  

### Contact

| Purpose | Contact|
|-------|---------|
| **TOOL owner** | Stephen J Akers, Gregg Labranche


