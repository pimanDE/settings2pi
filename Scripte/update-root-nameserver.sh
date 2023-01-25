#!/bin/bash
#
# Aktualisierung der Root-Nameserver (root.hints)
#
#
#
#####################################################################################################################
# Start des Script's

clear



# Aktualisierung der Root-Nameserver

wget -O root.hints https://www.internic.net/domain/named.root &&
mv -fv root.hints /var/lib/unbound/ &&
sudo service unbound restart || echo "ACHTUNG! Unbound Fehler!" | s-nail -A MAIL -s "ACHTUNG! Update der Root-Nameserver auf rechnername war fehlerhaft! Unbound wurde nicht gestartet!" meine-email@gmx.net

date +'%d.%m.%Y um %H:%M:%S Uhr' >> /home/benutzername/Log/updates-root-nameserver.log 


exit
