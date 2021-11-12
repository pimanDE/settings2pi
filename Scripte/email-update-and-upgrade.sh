#!/bin/bash
#
# Mit diesem Script wird am letztes Tag des Monats eine Mail gesendet, mit der Info der letzten Aktualisierungen
#
#
#
####################################################################################################################
# Start des Script's

clear



echo "Letzte Updates des Systems am:" > /home/benutzername/Log/last-updates.txt
tail -4 /home/benutzername/Log/update-and-upgrade.log >> /home/benutzername/Log/last-updates.txt

cat /home/benutzername/Log/last-updates.txt | s-nail -A MAIL -s 'Info über letzte Systemupdates auf rechnername.' meine-email@gmx.net

exit
