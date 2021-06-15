#!/bin/bash
#
# Aktualisierung der Root-Nameserver (root.hints)
#
#
#
#####################################################################################################################
# Start des Script's

clear
set -e



####################################################################################################################
# Setzen der Variablen

username=`whoami`
hostname=`hostname`
ipadresse=`hostname -I`

standard="\033[0m"
grau="\033[1;30m"
rotfett="\033[1;31m"
blaufett="\033[1;34m"
gruenfett="\033[1;32m"

info="[i]"
over="\\r\\033[K"
fehler="[${rotfett}✗${standard}]"
haken="[${gruenfett}✓${standard}]"
done="${gruenfett} done!${standard}"



####################################################################################################################
# Aktualisierung der Root-Nameserver

cd /tmp
wget -O root.hints https://www.internic.net/domain/named.root

sudo rm /var/lib/unbound/root.hints
sudo mv root.hints /var/lib/unbound/

sudo service unbound restart


echo 'Unbound erfolgreich aktualisiert' >> /home/benutzername/Log/update-root-nameserver.log
date +"am %A, den %d. %B %Y um %H:%M:%S Uhr" >> /home/benutzername/Log/update-root-nameserver.log
echo '#####################################################' >> /home/benutzername/Log/update-root-nameserver.log
echo >> /home/benutzername/Log/update-root-nameserver.log
echo >> /home/benutzername/Log/update-root-nameserver.log


exit
