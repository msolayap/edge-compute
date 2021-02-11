#!/bin/bash

site_file_dir=`dirname $0` ;

api_output=`mktemp`;
tmpfile=`mktemp`;
site_file=$site_file_dir/site_devices.csv

curl -s --insecure https://houdini.edg.centurylink.net/api/v1/peportconfig/?limit=1000000\&offset=0 >$api_output  2>&1

if [ $? -eq 0 ];
then
	cat $api_output | ./jq -r '[.results[]|select(.role|startswith("edge"))|{site,role,router_hostname,connection_aggregate}]|group_by(.site)|flatten(1)|.[]|to_entries|map(.value)|@csv' | sort -u |  tr -d '"' | uniq --check-chars=16 >$tmpfile ;

	if [ $? -ne 0 ]
	then
		echo "Error while fetching device data from API. Old file is kept intact. Look at $api_output and $tmpfile for error details" ;
		exit 1;
	fi
	  
	echo "name,ear_1_connection_aggregate,ear_1_router_hostname,ear_2_connection_aggregate,ear_2_router_hostname" >$site_file
	for site in `cat $tmpfile |cut -f1 -d, | sort -u | uniq` ;
	do
		ear_1_connection_aggregate=`cat $tmpfile | grep "$site" | grep 'edge-1' | cut -f4 -d,`
		ear_1_router_hostname=`cat $tmpfile | grep "$site" | grep 'edge-1' | cut -f3 -d,`
		ear_2_connection_aggregate=`cat $tmpfile | grep "$site" | grep 'edge-2' | cut -f4 -d,`
		ear_2_router_hostname=`cat $tmpfile | grep "$site" | grep 'edge-2' | cut -f3 -d,`

		echo "$site,$ear_1_connection_aggregate,$ear_1_router_hostname,$ear_2_connection_aggregate,$ear_2_router_hostname" >>$site_file ;
	done
	rm -f $tmpfile 2>/dev/null
	#echo "Site data retrieved from Houdini API - houdini.edg.centurylink.net/api"
	exit 0;
else
	echo "Error while fetching device data from API. Old file is kept intact. Look at $api_output for error details" ;
	exit 1;
fi
