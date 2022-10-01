#!/bin/bash
#
# Mit diesem Script wird die eigene E-Mail im System hinterlegt, sodass E-Mail versendet werden können
# getestet auf Raspberry Pi OS Lite Release vom 22. September 2022
#
# Benutzung auf eigene Gefahr!!!
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

date=`date +'%Y%m%d-%H%M%S'`

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
# Abfragen

while ! ((antwortok)); do
	echo
	echo "   Bitte geben Sie hier Ihre E-Mail Adresse ein."
	echo "   Über diese Adresse werden die E-Mails versendet und empfangen."
	echo

	read -p "   Meine E-Mail Adresse ist: " emailadresse

	echo
	echo

	echo -e "   E-Mail Adresse:     " ${blaufett} $emailadresse ${standard}
	echo

	while :; do

       echo
       read -p "   Ist die Angabe richtig? [j/N]: " antwort
       case "$antwort" in
           j)
               antwortok=1
               break
               ;;
           N|n|"")
              break
               ;;
           *)
               ;;
       esac
   done
done



# E-Mail im System anpassen
sudo wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Dateien/s-nail/s-nail.rc -P /etc/
sudo chmod 777 /etc/s-nail.rc
sudo rpl --encoding UTF-8 'meine-email@gmx.net' $emailadresse /etc/s-nail.rc > /dev/null 2>&1
echo
echo
echo
echo "   Bitte das E-Mail Passwort eintragen ..."
echo
read -p "   Weiter mit ENTER ..."
sudo nano +225,24 /etc/s-nail.rc								# Passwort des E-Mail Accounts eintragen
sudo chown $username:$username /etc/s-nail.rc                   # Eigentümer festlegen
sudo chmod 400 /etc/s-nail.rc									# Leserechte setzen



# E-Mail Adresse für Empfang der Systemanmeldung eintragen
sudo chmod 777 /etc/profile
sudo echo "/home/$username/Scripte/ssh-login/ssh-login.sh | s-nail -A MAIL -s 'SSH Login auf $hostname' meine-email@gmx.net > /dev/null 2>&1" >> /etc/profile
sudo rpl --encoding UTF-8 'meine-email@gmx.net' $emailadresse /etc/profile > /dev/null 2>&1
sudo chmod 644 /etc/profile



# E-Mail beim Login
mkdir -p /home/$username/Scripte/ssh-login
wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Scripte/ssh-login.sh -P ~/Scripte/ssh-login/
chmod 554 ~/Scripte/ssh-login/ssh-login.sh         # siehe Eräuterungen zum Script (https://github.com/pimanDE/settings2pi/Erläuterungen%20zum%20Script)



# E-Mail Adresse in den Scripten anpassen
sudo chmod 777 /home/$username/Scripte/*pdate*.sh
sudo rpl --encoding UTF-8 'meine-email@gmx.net' $emailadresse /home/$username/Scripte/update-and-upgrade.sh > /dev/null 2>&1
sudo rpl --encoding UTF-8 'meine-email@gmx.net' $emailadresse /home/$username/Scripte/email-update-and-upgrade.sh > /dev/null 2>&1
sudo chmod 554 /home/$username/Scripte/*pdate*.sh


exit
