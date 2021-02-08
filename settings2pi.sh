#!/bin/bash
#
# Mit diesem Script werden verschiedene Programme installiert und diverse Einstellungen am Raspberry Pi automatisch vorgenommen.
# getestet auf Raspberry Pi OS Lite Release vom 11. Januar 2021
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

#touch /tmp/error-settings2pi.log
#exec 2> /tmp/error-settings2pi.log



####################################################################################################################
# Abfragen

echo
echo

echo -e "   ${blaufett}Die Installation und Konfiguration des Raspberry's beginnt ...${standard}"
echo
echo
sleep 2

while ! ((antwortok)); do
	echo
	echo "   Sie können den SSH-Port ändern. Geben Sie die 22 für den Standard-Port, oder eine andere Portnummer ein."
	echo

	read -p "   SSH-Port: " sshport

	echo
	echo

	echo -e "   SSH-Port:     " ${blaufett} $sshport ${standard}
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

echo
echo

echo -e "   Dein SSH-Port ist:"$'\t'${blaufett} $sshport ${standard}
echo -e "   Dein Username ist:"$'\t'${blaufett} $username ${standard}
echo -e "   Dein Rechnername ist:"$'\t'${blaufett} $hostname ${standard}
echo -e "   Deine IP Adresse ist:"$'\t'${blaufett} $ipadresse ${standard}
echo

read -p "   Mit beliebiger Taste weiter ... "



# Zu ignorierende IP Adresse/n für fail2ban

echo
while ! ((antwortignoreip)); do
        echo
        echo "   fail2ban kann einen oder mehrere Rechner vom Blocken ausnehmen."
        echo "   Hierzu ist die Eingabe der IP Adresse/n notwendig."
        echo "   Mehrere IP Adressen werden durch Leerzeichen getrennt eingegeben."
        read -p "   Bitte geben Sie die IP Adresse/n ein: " ignoreip
     echo
     echo
     echo -e "   Die IP Adresse/n lautet/n: "${blaufett} $ignoreip ${standard}
       while :; do
       echo
       read -p "   Ist/Sind die Angabe/n richtig? [j/N]: " antwort
       case "$antwort" in
           j)
               antwortignoreip=1
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



####################################################################################################################
# Anlegen von Ordner, Erstellen von Scripten, Listen etc.

mkdir /home/$username/Downloads
touch /home/$username/Log/settings2pi.log

# sudo rpl "1200" "60000" /etc/sudoers > /dev/null 2>&1		# falls das Script länger dauert, behalten wir root-Rechte (wird am Ende wieder zurückgestellt)

echo
echo



####################################################################################################################
# Update der Quellen und Installation diverser Programme

echo
echo

echo -e "${blaufett}   Aktualisiere das System ...${standard}"

echo
echo

sudo apt update
sudo apt upgrade -y
sudo apt install -y dialog git locate lsof

echo 'Update und Upgrade erfolgreich' > /home/$username/Log/update-and-upgrade.log
date +'am %A, den %d. %B %Y um %H:%M:%S Uhr' >> /home/$username/Log/update-and-upgrade.log
echo '#####################################################' >> /home/$username/Log/update-and-upgrade.log
echo >> /home/$username/Log/update-and-upgrade.log
echo >> /home/$username/Log/update-and-upgrade.log

echo '   1. Update der Quellen und Installation diverser Programme erfolgreich' >> ~/Log/settings2pi.log
echo
echo
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}1. Update der Quellen und Installation diverser Programme erfolgreich${standard} +"
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



####################################################################################################################
# ssh absichern

echo
echo

echo -e "${blaufett}   Absichern des ssh-Ports ...${standard}"

echo
echo

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig							# http://www.openbsd.org/cgi-bin/man.cgi/OpenBSD-current/man5/sshd_config.5?query=sshd_config&sec=5
sudo chmod 777 /etc/ssh/sshd_config										# Dateirechte setzen
sudo rpl '#Port 22' "Port $sshport" /etc/ssh/sshd_config > /dev/null 2>&1					# Neuer ssh-Port
sudo rpl '#ListenAddress 0.0.0.0' "ListenAddress $ipadresse" /etc/ssh/sshd_config > /dev/null 2>&1		# ssh hört nur auf dieser IP-Adresse (manchmal hat ein Server mehrere IP Adressen)
sudo rpl '#LogLevel INFO' 'LogLevel VERBOSE' /etc/ssh/sshd_config > /dev/null 2>&1				# ausführliches LogLevel
sudo rpl '#LoginGraceTime 2m' 'LoginGraceTime 1m' /etc/ssh/sshd_config > /dev/null 2>&1			# wenn innerhalb von 1 Minute kein erfolgreicher Login stattgefunden hat, wird der Zugriff getrennt
sudo rpl '#PermitRootLogin prohibit-password' 'PermitRootLogin prohibit-password' /etc/ssh/sshd_config > /dev/null 2>&1		# root darf sich nicht mit einem Password anmelden
sudo rpl '#StrictModes yes' 'StrictModes yes' /etc/ssh/sshd_config > /dev/null 2>&1				# https://wiki.hetzner.de/index.php/Sshd
sudo rpl '#MaxAuthTries 6' 'MaxAuthTries 3' /etc/ssh/sshd_config > /dev/null 2>&1				# 3 mal falsches Passwort, dann wird die Verbindung getrennt
sudo rpl '#MaxSessions 10' 'MaxSessions 3' /etc/ssh/sshd_config > /dev/null 2>&1				# gibt die maximale Anzahl von offenen Sitzungen pro Verbindung an
sudo rpl '#PrintLastLog yes' 'PrintLastLog no' /etc/ssh/sshd_config > /dev/null 2>&1				# Ausschalten der Info
sudo rpl '#MaxStartups 10:30:100' 'MaxStartups 3:30:10' /etc/ssh/sshd_config > /dev/null 2>&1			# gibt die maximale Anzahl gleichzeitiger nicht authentifizierter Verbindungen zum SSH-Daemon an
sudo rpl 'X11Forwarding yes' 'X11Forwarding no' /etc/ssh/sshd_config > /dev/null 2>&1				# keine Weiterleitung der grafischen Benutzerobefläche
sudo rpl '#TCPKeepAlive yes' '#TCPKeepAlive no' /etc/ssh/sshd_config > /dev/null 2>&1				# https://blog.buettner.xyz/sichere-ssh-konfiguration/
sudo rpl '#Banner none' 'Banner /etc/ssh/banner' /etc/ssh/sshd_config > /dev/null 2>&1			# Angabe des Pfades der Bannerdatei (Begrüßungstext)
sudo rpl '#HostbasedAuthentication no' '#HostbasedAuthentication yes' /etc/ssh/sshd_config > /dev/null 2>&1	# https://blog.buettner.xyz/sichere-ssh-konfiguration/
sudo rpl '#IgnoreRhosts yes' 'IgnoreRhosts yes' /etc/ssh/sshd_config > /dev/null 2>&1				# https://blog.buettner.xyz/sichere-ssh-konfiguration/
sudo rpl '#PasswordAuthentication yes' 'PasswordAuthentication yes' /etc/ssh/sshd_config > /dev/null 2>&1	# Anmeldung nur mit Passwort
sudo rpl '#PermitEmptyPasswords no' 'PermitEmptyPasswords no' /etc/ssh/sshd_config > /dev/null 2>&1		# Benutzer die kein Passwort haben, dürfen sich nicht anmelden

echo >> /etc/ssh/sshd_config > /dev/null 2>&1

sudo echo 'MaxStartups 3' >> /etc/ssh/sshd_config							# als Zusatz zu MaxStartups 3 (ist wahrscheinlich gleich/ähnlich)
sudo echo 'RSAAuthentication no' >> /etc/ssh/sshd_config						# da es nur Protokoll Version 1 betrifft ist es nicht wichtig zu setzen, wird trotzdem gemacht
sudo echo 'Protocol 2' >> /etc/ssh/sshd_config								# nur Protokoll 2
sudo echo 'DenyUsers root pi admin administrator' >> /etc/ssh/sshd_config				# die User root, pi, admin und administrator dürfen sich nicht anmelden
sudo echo 'DenyGroups root pi' >> /etc/ssh/sshd_config						# Mitglieder der Gruppen root und pi dürfen sich nicht anmelden
sudo echo "AllowUsers $username" >> /etc/ssh/sshd_config						# nur der eigene User darf sich anmelden
sudo echo "AllowGroups $username" >> /etc/ssh/sshd_config						# nur der eigene User der Gruppe eigeneUser darf sich anmelden
sudo echo 'RhostsRSAAuthentication no' >> /etc/ssh/sshd_config					# https://wiki.hetzner.de/index.php/Sshd
sudo echo 'PermitRootLogin no' >> /etc/ssh/sshd_config						# ähnlich wie 'PermitRootLogin prohibit-password'
sudo echo >> /etc/ssh/sshd_config

sudo chmod 555 /etc/ssh/sshd_config									# Dateirechte setzen

sudo touch /etc/ssh/banner										# Bannerdatei erstellen
sudo chmod 777 /etc/ssh/banner
sudo echo > /etc/ssh/banner
sudo echo >> /etc/ssh/banner
sudo echo "+++++++++++++++++++" >> /etc/ssh/banner
sudo echo "| Login on $hostname |" >> /etc/ssh/banner
sudo echo "+++++++++++++++++++" >> /etc/ssh/banner
sudo echo >> /etc/ssh/banner
sudo chmod 644 /etc/ssh/sshd_config									# Dateirechte setzen

sudo /etc/init.d/ssh restart										# anschließender Login: ssh onion@192.168.178.11 -p 31307

echo '   2. ssh erfolgreich abgesichert' >> ~/Log/settings2pi.log
echo
echo
echo "   ++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}2. ssh erfolgreich abgesichert${standard} +"
echo "   ++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



####################################################################################################################
# fail2ban konfigurieren
# ignoreip = EigeneIPAdresse	--> diese IP wird ignoriert, alle anderen haben 3 Versuche, dann wird für 24h geblockt

echo
echo

echo -e "${blaufett}   Installiere fail2ban ...${standard}"

echo
echo

sudo apt install -y fail2ban

sudo wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/main/Dateien/fail2ban/jail.local -P /etc/fail2ban/
sudo rpl "username" "$username" /etc/fail2ban/jail.local > /dev/null 2>&1				# den eigenen Benutzer hinzufügen
sudo rpl "IgnorierteIP" "$ignoreip" /etc/fail2ban/jail.local > /dev/null 2>&1				# IP Adresse/n hinzufügen, die fail2ban ignorieren soll
sudo chmod 644 /etc/fail2ban/jail.local

# https://kopfkino.irosaurus.com/tutorial-server-mit-fail2ban-absichern/
sudo cp /etc/fail2ban/action.d/iptables-common.conf /etc/fail2ban/action.d/iptables-common.conf.orig
sudo rpl "blocktype = REJECT --reject-with icmp-port-unreachable" "blocktype = DROP" /etc/fail2ban/action.d/iptables-common.conf > /dev/null 2>&1
sudo rpl "blocktype = REJECT --reject-with icmp6-port-unreachable" "blocktype = DROP" /etc/fail2ban/action.d/iptables-common.conf > /dev/null 2>&1


echo '   3. fail2ban erfolgreich konfiguriert' >> ~/Log/settings2pi.log
echo
echo
echo "   ++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}3. fail2ban erfolgreich konfiguriert${standard} +"
echo "   ++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



####################################################################################################################
# Veracrypt installieren

echo
echo
echo -e "${blaufett}   Installiere veracrypt ...${standard}"
echo
echo

wget https://launchpad.net/veracrypt/trunk/1.24-update7/+download/veracrypt-console-1.24-Update7-Debian-10-armhf.deb
sudo dpkg -i veracrypt-console-1.24-Update7-Debian-10-armhf.deb
rm veracrypt-console-1.24-Update7-Debian-10-armhf.deb

# veracrypt -m=nokernelcrypto --truecrypt Quelle Ziel/		# --truecrypt = Einbinden von Truecryptbasierten Dateisystemen
# veracrypt -m=nokernelcrypto --truecrypt /dev/sda1 /mnt/

echo '   4. Veracrypt erfolgreich installiert' >> ~/Log/Erstinstallation.log
echo
echo
echo "   ++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}4. Veracrypt erfolgreich installiert${standard} +"
echo "   ++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



#####################################################################################################################
# s-nail installieren und konfigurieren

echo
echo

echo -e "${blaufett}   s-nail wird installiert ...${standard}"

echo
echo
sudo apt install -y s-nail

sudo mv /etc/s-nail.rc /etc/s-nail.rc.orig

sudo wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/main/Dateien/s-nail/s-nail.rc -P /etc/
sudo chown $username:$username /etc/s-nail.rc
sudo chmod 440 /etc/s-nail.rc

mkdir ~/Scripte/ssh-login
wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/main/Dateien/s-nail/ssh-login.sh -P ~/Scripte/ssh-login/
chmod 550 ~/Scripte/ssh-login/ssh-login.sh

# siehe Eräuterungen zum Script (https://github.com/pimanDE/settings2pi/Erläuterungen%20zum%20Script)
sudo chmod 777 /etc/profile
sudo echo "/home/$username/Scripte/ssh-login/ssh-login.sh | s-nail -A MAIL -s 'SSH Login auf $hostname' email@gmx.net" >> /etc/profile	# bei jedem ssh-Login wird eine E-Mail versendet
sudo chmod 644 /etc/profile

# echo "Dieser Text erscheint in der Mail" | s-nail -A MAIL -s "Dieser Text erscheint im Betreff" email@gmx.net

echo
echo
echo '   5. s-nail wurde erfolgreich installiert und konfiguriert' >> ~/Log/settings2pi.log
echo
echo
echo "   +++++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}5. s-nail wurde erfolgreich installiert${standard} +"
echo "   +++++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2





####################################################################################################################
# Cache leeren

echo
echo

echo -e "${blaufett}   Leeren des Caches ...${standard}"

echo
echo

sudo apt clean				# Leeren des Paketcaches (Entfernen von zur Installation heruntergeladenen Paketen)
sudo apt autoclean			# wie clean, nur werden ausschließlich Pakete, die nicht mehr in den Quellen verfügbar sind, gelöscht
sudo apt autoremove			# Deinstallation ungenutzter Abhängigkeiten


echo '   6. Cache wurde erfolgreich geleert' >> ~/Log/settings2pi.log
echo
echo
echo "   ++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}6. Cache wurde erfolgreich geleert${standard} +"
echo "   ++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



####################################################################################################################
# Nacharbeiten

# echo
# echo


####################################################################################################################
# Meldung über Abschluss

clear
echo
echo
echo
echo -e "${gruenfett}   Script ohne Fehler erfolgreich durchlaufen!${standard}"
echo
echo -e "   siehe auch /home/$username/Log/settings2pi.log"
echo
echo

sudo chown root:root /home/$username/Log/settings2pi.log



####################################################################################################################
# Neustart des Rechners

echo
echo

echo "   Der Rechner muss nun neu gestartet werden."
echo
echo

echo -e "${rotfett}   Hinweis bei ssh-Portänderung:${standard}"
echo -e "${rotfett}   Login: ssh benutzername@rechner-ip -p neue-ssh-portnummer${standard}"
echo -e "${rotfett}   Beispiel: ssh pimanDE@192.168.178.30 -p 4711${standard}"

echo

echo -e "${rotfett}   Um s-nail zu konfigurieren, lesen Sie bitte${standard}"
echo -e "${rotfett}   die Erläuterungen zum Script in der Dokumentation.${standard}"

echo
echo


read -p "   Neustart mit beliebiger Taste bestätigen ... "
echo
echo

echo "   Der Rechner wird neu gestartet ... "
echo
echo
sleep 2

echo
echo
sudo reboot

exit