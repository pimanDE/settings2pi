#!/bin/bash
#

set -e

sudo apt update
sudo apt upgrade -y
echo 'Update und Upgrade erfolgreich' >> /home/username/Log/update-and-upgrade.log &&
date +'am %A, den %d. %B %Y um %H:%M:%S Uhr' >> /home/username/Log/update-and-upgrade.log &&
echo '#####################################################' >> /home/username/Log/update-and-upgrade.log &&
echo >> /home/username/Log/update-and-upgrade.log &&
echo >> /home/username/Log/update-and-upgrade.log &&

exit
