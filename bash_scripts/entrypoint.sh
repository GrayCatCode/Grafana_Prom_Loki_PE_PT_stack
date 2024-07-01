#!/bin/bash

# entrypoint.sh log file:
LOG_FILE=/var/log/entrypoint.log

# PGExporter lock file:
PGEXPORTER_LOCK_FILE=/tmp/pgexporter.lock

{
   echo "Executing /root/entrypoint.sh ..."

   # Start the promtail service:
   echo "Starting the promtail service ... "
   systemctl start -v promtail

   # Start the process exporter service:
   echo "Starting the process exporter service ... "

   systemctl start -v process-exporter

   # Start the PostgeSQL database service:
   echo "Starting the PostgreSQL database service ..."
   systemctl start -v postgresql-16

   # Start the PostgreSQL Exporter process:
   # Check if the PostgreSQL Exporter lock file still exists; if so, delete it:
   if [ -f "$PGEXPORTER_LOCK_FILE" ] ; then
      rm "$PGEXPORTER_LOCK_FILE"
   fi
   echo "Starting the PGExporter service ..."
   su - postgres -c "pgexporter -c /etc/pgexporter/pgexporter.conf -u pgexporter_users.conf &"

   # Infinite loop to keep the container running:
   while true; do

      date "+DATE: %D TIME: %T";
      python3 ~/Python_code/log-gen.py;
      python3 ~/Python_code/python_client_demo.py;
      sleep 15;

   done

} 2>&1 | tee -a -i "$LOG_FILE"

exit 0
