#!/bin/bash
#
# Mit diesem Script werden einige Vorbereitungen für das Script settings2pi.sh getroffen.
# getestet auf Raspberry Pi OS Lite Release vom 11. Januar 2021
#
# Benutzung auf eigene Gefahr!!!
#
######################################################################################################################
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
# Anlegen von benötigten Verzeichnissen

cd /home/$username

mkdir -p Log
mkdir -p Scripte
mkdir -p Downloads

# touch /tmp/error-preparations2pi.log
# exec 2>&1 /tmp/error-preparations2pi.log



####################################################################################################################
# Installation von rpl

echo
echo

if dpkg-query -s rpl 2>/dev/null|grep -q installed;
	then
	echo
	else
	echo -e "   ${blaufett}rpl wird installiert ...${standard}"
	echo
	echo
	sudo apt install -y rpl
fi

echo

echo '   1. rpl wurde erfolgreich installiert.' >> ~/Log/preparations2pi.log
echo
echo
echo "   +++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}1. rpl wurde erfolgreich installiert.${standard} +"
echo "   +++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2


####################################################################################################################
# Hinzufügen eines neuen Benutzers und Ändern des Rechnernamens

clear
echo
echo

echo -e "   ${blaufett}Hinzufügen eines neuen Benutzers und ändern des Rechnernamens wird vorbereitet ...${standard}"
echo
echo
sleep 2

while ! ((antwortok)); do
        echo
	read -p "   Wie soll der neue Benutzername lauten: " neuerbenutzer
        read -p "   Wie soll der neue Rechnername lauten: " rechnername
     echo
     echo
     echo -e "   Der neue Benutzername ist jetzt:"${blaufett} $neuerbenutzer ${standard}
     echo -e "   Der neue Rechnername ist jetzt:" ${blaufett} $rechnername ${standard}
       while :; do
       echo
       read -p "   Sind die Angaben richtig? [j/N]: " antwort
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

echo
echo

# Neuen Benutzer hinzufügen
sudo adduser --gecos "" $neuerbenutzer
# Neuen Benutzer den Gruppen hinzufügen
sudo usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio $neuerbenutzer

# User pi deaktivieren
sudo usermod -L pi
echo
echo -e "   ${rotfett}Benutzer pi wurde deaktiviert!${standard}"

# Ändern des Rechnernamens
sudo rpl "raspberrypi" "$rechnername" /etc/hosts > /dev/null 2>&1
sudo rpl "raspberrypi" "$rechnername" /etc/hostname > /dev/null 2>&1

sudo hostname -F /etc/hostname		# https://wiki.ubuntuusers.de/Rechnername/#Terminal


echo '   2. Benutzer hinzugefügt und Rechnername erfolgreich geändert.' >> ~/Log/preparations2pi.log
echo
echo
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}2. Benutzer hinzugefügt und Rechnername erfolgreich geändert.${standard} +"
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



####################################################################################################################
# Sprache auf deutsch und Zeitzone auf Berlin/Europa ändern

# Sprache ändern
echo
echo

echo -e "   ${blaufett}Sprache wird auf deutsch geändert ...${standard}"
echo
echo
sudo rpl '# de_DE.UTF-8 UTF-8' 'de_DE.UTF-8 UTF-8' /etc/locale.gen > /dev/null 2>&1
sudo rpl 'LANG=en_GB.UTF-8' 'LANG=de_DE.UTF-8' /etc/default/locale > /dev/null 2>&1
sudo locale-gen

# Zeitzone auf Berlin/Europa ändern
sudo ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

echo
echo

echo '   3. Sprache und Zeitzone erfolgreich geändert.' >> ~/Log/preparations2pi.log
echo
echo
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}3. Sprache und Zeitzone erfolgreich geändert.${standard} +"
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



####################################################################################################################
# WLAN einstellen

# Abfrage
while ! ((antwortwlan)); do
	echo
	echo
   while :; do
        echo
        read -p "   WLAN Kanal 12 und 13 (Deutschland) aktivieren? [j/N]: " antwort
        case "$antwort" in
	   j)
		antwortwlan=1
		echo
		echo -e "   ${blaufett}WLAN wird eingestellt ...${standard}"
		sleep 2
		sudo chmod 777 /etc/wpa_supplicant/wpa_supplicant.conf
		sudo echo "country=DE" >> /etc/wpa_supplicant/wpa_supplicant.conf
		sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf
		echo
		echo

		echo '   4. WLAN Kanäle wurden erfolgreich freigeschaltet.' >> ~/Log/preparations2pi.log
		echo
		echo
		echo "   ++++++++++++++++++++++++++++++++++++++++++++++++"
		echo -e "   + ${gruenfett}3. WLAN Kanäle wurden erfolgreich aktiviert.${standard} +"
		echo "   ++++++++++++++++++++++++++++++++++++++++++++++++"
		echo
		echo
		sleep 2

	       break
               ;;
           N|n|"")
                antwortwlan=2
		echo
		echo

		echo '   4. WLAN Kanäle wurden nicht freigeschaltet.' >> ~/Log/preparations2pi.log
		echo
		echo
		echo "   +++++++++++++++++++++++++++++++++++++++++++++++"
		echo -e "   + ${gruenfett}3. WLAN Kanäle wurden nicht freigeschaltet.${standard} +"
		echo "   +++++++++++++++++++++++++++++++++++++++++++++++"
		echo
		echo
		sleep 2

                break
               ;;
           *)
               ;;
       esac
   done
done



####################################################################################################################
# Nacharbeiten

# Verzeichnisse und Dateien dem neuen Benutzer übergeben

sudo mv /home/$username/Scripte /home/$neuerbenutzer
sudo mv /home/$username/Log /home/$neuerbenutzer

sudo chown $neuerbenutzer:$neuerbenutzer /home/$neuerbenutzer/Scripte
sudo chown $neuerbenutzer:$neuerbenutzer /home/$neuerbenutzer/Log

sudo chown $neuerbenutzer:$neuerbenutzer /home/$neuerbenutzer/Log/preparations2pi.log


####################################################################################################################
# Neustart des Rechners

echo
echo

echo "   Der Rechner muss nun neu gestartet werden."
echo
echo

echo -e "   Nach dem Neustart bitte mit dem Benutzernamen ${gruenfett}$neuerbenutzer${standard} und dem neuen Passwort anmelden."
echo
echo

read -p "   Neustart mit beliebiger Taste bestätigen ... "
echo
echo

echo "   Der Rechner wird neu gestartet ... "
echo
echo
sleep 2

sudo reboot

exit
