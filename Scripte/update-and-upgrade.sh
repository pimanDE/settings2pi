#!/bin/bash
#

set -e

sudo apt update
sudo apt upgrade -y
echo 'Update und Upgrade erfolgreich' >> /home/benutzername/Log/update-and-upgrade.log &&
date +'am %A, den %d. %B %Y um %H:%M:%S Uhr' >> /home/benutzername/Log/update-and-upgrade.log &&
echo '#####################################################' >> /home/benutzername/Log/update-and-upgrade.log &&
echo >> /home/benutzername/Log/update-and-upgrade.log &&
echo >> /home/benutzername/Log/update-and-upgrade.log &&

exit
