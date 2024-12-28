#!/bin/bash
#
# Mit diesem Script wird das Betriebssystem aktualisiert.
#
#
#
#####################################################################################################################
# Start des Script's

clear

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y &&
date +'%d.%m.%Y um %H:%M:%S Uhr' >> /home/benutzername/Log/update-and-upgrade.log || echo "ACHTUNG! Systemupdate auf rechnername war fehlerhaft!" | s-nail -A MAIL -s "ACHTUNG! Systemupdate auf rechnername war fehlerhaft!" meine-email@gmx.net

exit

