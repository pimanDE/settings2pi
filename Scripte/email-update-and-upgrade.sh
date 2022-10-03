#!/bin/bash
#
# Mit diesem Script wird am ersten Tag des Monats eine E-Mail gesendet, mit der Info der letzten Aktualisierungen
#
#
#
####################################################################################################################
# Start des Script's

clear



echo "Letzte Updates des Systems auf rechnername am:" > /home/benutzername/Log/updates-and-upgrades.log
tail -4 /home/benutzername/Log/update-and-upgrade.log >> /home/benutzername/Log/updates-and-upgrades.log

cat /home/benutzername/Log/letzte-updates-system.log | s-nail -A MAIL -s 'Info über letzte Systemupdates auf rechnername.' meine-email@gmx.net

exit
