#!/bin/bash

benutzer=`pinky | tail -1 | awk '{ print $1 }'`
ipadresse=`pinky | tail -1 | awk '{ print $5 }'`

echo
echo

echo "Login auf $(hostname) am $(date +%d.%m.%Y) um $(date +%H:%M) Uhr."
echo
echo Benutzername: $benutzer
echo von der IP-Adresse: $ipadresse

echo
echo

exit

