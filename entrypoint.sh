#!/bin/bash
if [[ -z "${WarName}" ]]; then
   echo "No War Name Provided. Exiting....."
   exit 0
else
    mkdir -p /var/log/filebeat
    /usr/share/filebeat/bin/filebeat -c /etc/filebeat/filebeat.yml > /var/log/filebeat/out.log 2> /var/log/filebeat/error.log &
    cp -r /app/$WarName $CATALINA_HOME/webapps
fi
./bin/catalina.sh run
