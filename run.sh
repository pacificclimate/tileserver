#!/bin/bash

set -x

# Clean /tmp
rm -rf /tmp/*

# Configure Apache CORS
if [ "$ALLOW_CORS" == "1" ]; then
    echo "export APACHE_ARGUMENTS='-D ALLOW_CORS'" >> /etc/apache2/envvars
fi

service apache2 restart

# start cron job to trigger consecutive updates
if [ "$UPDATES" = "enabled" ]; then
  /etc/init.d/cron start
fi

# Run
while true;
do sleep 600;
done;

exit 0
