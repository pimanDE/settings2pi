#!/bin/bash
#
# Aktualisierung des Systems
#
#
#
#####################################################################################################################
# Start des Script's

clear



# Aktualisierung des Systems

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y &&
date +'%d.%m.%Y um %H:%M:%S Uhr' >> /home/benutzername/Log/update-and-upgrade.log || echo "ACHTUNG! Systemupdate auf rechnername war fehlerhaft!" | s-nail -A MAIL -s "ACHTUNG! Systemupdate auf rechnername war fehlerhaft!" meine-email@gmx.net


exit
