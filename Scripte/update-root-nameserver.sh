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

cd /tmp &&
wget -O root.hints https://www.internic.net/domain/named.root &&
sudo rm /var/lib/unbound/root.hints &&
sudo mv root.hints /var/lib/unbound/ &&
sudo service unbound restart &&
date +'%d.%m.%Y um %H:%M:%S Uhr' >> /home/benutzername/Log/update-root-nameserver.log || echo "ACHTUNG! Update der root.hints auf rechnername war fehlerhaft!" | s-nail -A MAIL -s "ACHTUNG! Update der root.hints auf rechnername war fehlerhaft!" meine-email@gmx.net
echo 'Update der root.hints auf rechnername war erfolgreich.' | s-nail -A MAIL -s 'Update der root.hints auf rechnername war erfolgreich.' meine-email@gmx.net


exit
