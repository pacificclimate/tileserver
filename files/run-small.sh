#!/bin/bash

set -x

ln -sf /proc/$$/fd/1 /var/log/apache2/access.log
ln -sf /proc/$$/fd/2 /var/log/apache2/error.log
service apache2 restart

# Run
while true;
do sleep 600;
done;

exit 0
