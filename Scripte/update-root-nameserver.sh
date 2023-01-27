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
mv -f root.hints /var/lib/unbound/ &&
date +'%d.%m.%Y um %H:%M:%S Uhr' >> /home/benutzername/Log/update-root-nameserver.log || echo "ACHTUNG! Update der Root-Nameserver auf rechnername war fehlerhaft! root.hints konnte nicht erneuert werden!" | s-nail -A MAIL -s "ACHTUNG! Unbound Fehler auf rechnername!" meine-email@gmx.net

sudo service unbound restart 



exit
