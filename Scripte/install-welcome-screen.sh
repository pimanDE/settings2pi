#!/bin/bash
#
# Script zum Installieren des Willkommensbildschirms
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
# Installation des Willkommensbildschirms

sudo cp /etc/motd /etc/motd.orig
sudo rm /etc/motd                                                               # löschen der ersten Login-Zeilen

sudo cp /etc/update-motd.d/10-uname /etc/update-motd.d/10-uname.orig
sudo rm /etc/update-motd.d/10-uname

sudo chmod 777 /etc/profile
sudo echo /home/$username/Scripte/welcome-screen.sh >> /etc/profile
sudo chmod 644 /etc/profile

sudo rpl '#PrintLastLog yes' 'PrintLastLog no' /etc/ssh/sshd_config > /dev/null 2>&1
sudo /etc/init.d/ssh restart  > /dev/null 2>&1

exit
