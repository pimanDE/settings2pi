#!/bin/bash
#
# Mit diesem Script werden verschiedene Programme installiert und diverse Einstellungen am Raspberry Pi automatisch vorgenommen.
# getestet auf Raspberry Pi OS Lite Release Bullseye vom 22. September 2022
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

read -p "   Weiter mit ENTER ... "



# Zu ignorierende IP Adresse/n für fail2ban

echo
while ! ((antwortignoreip)); do
        echo
        echo "   fail2ban kann einen oder mehrere Rechner vom Blocken ausnehmen."
        echo "   Hierzu ist die Eingabe der IP Adresse/n notwendig."
        echo "   Mehrere IP Adressen werden durch Leerzeichen getrennt eingegeben."
        echo
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
# Anlegen von Ordner, holen von Scripten, Listen etc.

cd /home/$username

mkdir -p /home/$username/Downloads
mkdir -p /home/$username/Scripte
mkdir -p /home/$username/Scripte/cron
mkdir -p /home/$username/Log

wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Scripte/update-and-upgrade.sh -P ~/Scripte/
wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Scripte/email-update-and-upgrade.sh -P ~/Scripte
wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Dateien/cron/cronjobs.txt -P ~/Scripte/cron

touch /home/$username/Log/settings2pi.log
touch /home/$username/Log/fail2ban.log                      # die jail.local verlangt danach

chmod 775 /home/$username/Log/settings2pi.log
chmod 775 /home/$username/Log/fail2ban.log

cd /home/$username/Scripte

# sudo rpl --encoding UTF-8 "1200" "60000" /etc/sudoers > /dev/null 2>&1     # falls das Script länger dauert, behalten wir root-Rechte (wird am Ende wieder zurückgestellt)

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
sudo apt install -y rpl dialog git locate lsof sqlite3

echo 'Update und Upgrade erfolgreich am:' > /home/$username/Log/update-and-upgrade.log
date +'%d.%m.%Y um %H:%M:%S Uhr' >> /home/$username/Log/update-and-upgrade.log


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

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig                                     # http://www.openbsd.org/cgi-bin/man.cgi/OpenBSD-current/man5/sshd_config.5?query=sshd_config&sec=5
sudo chmod 777 /etc/ssh/sshd_config                                                        # Dateirechte setzen
sudo rpl --encoding UTF-8 '#Port 22' "Port $sshport" /etc/ssh/sshd_config > /dev/null 2>&1                                   # Neuer ssh-Port
sudo rpl --encoding UTF-8 '#LogLevel INFO' 'LogLevel VERBOSE' /etc/ssh/sshd_config > /dev/null 2>&1                          # ausführliches LogLevel
sudo rpl --encoding UTF-8 '#LoginGraceTime 2m' 'LoginGraceTime 1m' /etc/ssh/sshd_config > /dev/null 2>&1                     # wenn innerhalb von 1 Minute kein erfolgreicher Login stattgefunden hat, wird der Zugriff getrennt
sudo rpl --encoding UTF-8 '#PermitRootLogin prohibit-password' 'PermitRootLogin no' /etc/ssh/sshd_config > /dev/null 2>&1    # root darf sich nicht anmelden (https://www.thomas-krenn.com/de/wiki/SSH_Root_Login_unter_Debian_verbieten)
sudo rpl --encoding UTF-8 '#StrictModes yes' 'StrictModes yes' /etc/ssh/sshd_config > /dev/null 2>&1                         # .....
sudo rpl --encoding UTF-8 '#MaxAuthTries 6' 'MaxAuthTries 3' /etc/ssh/sshd_config > /dev/null 2>&1                           # 3 mal falsches Passwort, dann wird die Verbindung getrennt
sudo rpl --encoding UTF-8 '#MaxSessions 10' 'MaxSessions 3' /etc/ssh/sshd_config > /dev/null 2>&1                            # gibt die maximale Anzahl von offenen Sitzungen pro Verbindung an
sudo rpl --encoding UTF-8 '#MaxStartups 10:30:100' 'MaxStartups 3:30:10' /etc/ssh/sshd_config > /dev/null 2>&1               # gibt die maximale Anzahl gleichzeitiger nicht authentifizierter Verbindungen zum SSH-Daemon an
sudo rpl --encoding UTF-8 '#PrintLastLog yes' 'PrintLastLog no' /etc/ssh/sshd_config > /dev/null 2>&1                        # Ausschalten der Info
sudo rpl --encoding UTF-8 'X11Forwarding yes' 'X11Forwarding no' /etc/ssh/sshd_config > /dev/null 2>&1                       # keine Weiterleitung der grafischen Benutzerobefläche
sudo rpl --encoding UTF-8 '#TCPKeepAlive yes' '#TCPKeepAlive no' /etc/ssh/sshd_config > /dev/null 2>&1                       # .....
sudo rpl --encoding UTF-8 '#Banner none' 'Banner /etc/ssh/banner' /etc/ssh/sshd_config > /dev/null 2>&1                      # Angabe des Pfades der Bannerdatei (Begrüßungstext)
sudo rpl --encoding UTF-8 '#HostbasedAuthentication no' 'HostbasedAuthentication no' /etc/ssh/sshd_config > /dev/null 2>&1   # .....
sudo rpl --encoding UTF-8 '#IgnoreRhosts yes' 'IgnoreRhosts yes' /etc/ssh/sshd_config > /dev/null 2>&1                       # .....
sudo rpl --encoding UTF-8 '#PasswordAuthentication yes' 'PasswordAuthentication yes' /etc/ssh/sshd_config > /dev/null 2>&1   # Anmeldung nur mit Passwort
sudo rpl --encoding UTF-8 '#PermitEmptyPasswords no' 'PermitEmptyPasswords no' /etc/ssh/sshd_config > /dev/null 2>&1         # Benutzer die kein Passwort haben, dürfen sich nicht anmelden

echo >> /etc/ssh/sshd_config > /dev/null 2>&1

sudo echo 'RSAAuthentication no' >> /etc/ssh/sshd_config                            # da es nur Protokoll Version 1 betrifft ist es nicht wichtig zu setzen, wird trotzdem gemacht
sudo echo 'Protocol 2' >> /etc/ssh/sshd_config                                      # nur Protokoll 2
sudo echo 'DenyUsers root pi admin administrator nobody' >> /etc/ssh/sshd_config    # die User root, pi, etc. dürfen sich nicht anmelden
sudo echo 'DenyGroups root pi admin administrator nobody' >> /etc/ssh/sshd_config   # Mitglieder der Gruppen root, pi, etc dürfen sich nicht anmelden
sudo echo "AllowUsers $username" >> /etc/ssh/sshd_config                            # nur der eigene User darf sich anmelden
sudo echo "AllowGroups $username" >> /etc/ssh/sshd_config                           # nur der eigene User der Gruppe eigeneUser darf sich anmelden
sudo echo 'RhostsRSAAuthentication no' >> /etc/ssh/sshd_config                      # .....
sudo echo 'AllowStreamLocalForwarding no' >> /etc/ssh/sshd_config                   # https://forum.kuketz-blog.de/viewtopic.php?t=8759
sudo echo 'AllowTcpForwarding no' >> /etc/ssh/sshd_config                           # https://forum.kuketz-blog.de/viewtopic.php?t=8759
sudo echo 'ClientAliveInterval 600' >> /etc/ssh/sshd_config                         # https://forum.kuketz-blog.de/viewtopic.php?t=8759

sudo echo >> /etc/ssh/sshd_config

sudo chmod 655 /etc/ssh/sshd_config                                                 # Dateirechte setzen

sudo touch /etc/ssh/banner                                                          # Bannerdatei erstellen
sudo chmod 777 /etc/ssh/banner
sudo echo > /etc/ssh/banner
sudo echo >> /etc/ssh/banner
sudo echo "+++++++++++++++++++++++" >> /etc/ssh/banner
sudo echo "| Login auf $hostname |" >> /etc/ssh/banner
sudo echo "+++++++++++++++++++++++" >> /etc/ssh/banner
sudo echo >> /etc/ssh/banner
sudo chmod 644 /etc/ssh/banner                                                      # Dateirechte setzen

sudo /etc/init.d/ssh restart                                                        # anschließender Login: ssh benutzername@IP-Adresse -p Portnummer


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

wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Dateien/fail2ban/jail.local -P /home/$username/Scripte/fail2ban
rpl --encoding UTF-8 "benutzername" $username /home/$username/Scripte/fail2ban/jail.local > /dev/null 2>&1				# den eigenen Benutzer hinzufügen
rpl --encoding UTF-8 "ssh-port" "$sshport" /home/$username/Scripte/fail2ban/jail.local > /dev/null 2>&1					# den ssh Port hinzufügen
rpl --encoding UTF-8 "IgnorierteIP" "$ignoreip" /home/$username/Scripte/fail2ban/jail.local > /dev/null 2>&1			# IP Adresse/n hinzufügen, die fail2ban ignorieren soll
sudo mv /home/$username/Scripte/fail2ban/jail.local /etc/fail2ban
sudo chmod 644 /etc/fail2ban/jail.local

# https://kopfkino.irosaurus.com/tutorial-server-mit-fail2ban-absichern/
sudo cp /etc/fail2ban/action.d/iptables-common.conf /etc/fail2ban/action.d/iptables-common.conf.orig
sudo rpl --encoding UTF-8 "blocktype = REJECT --reject-with icmp-port-unreachable" "blocktype = DROP" /etc/fail2ban/action.d/iptables-common.conf > /dev/null 2>&1
sudo rpl --encoding UTF-8 "blocktype = REJECT --reject-with icmp6-port-unreachable" "blocktype = DROP" /etc/fail2ban/action.d/iptables-common.conf > /dev/null 2>&1


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


echo '   4. Veracrypt erfolgreich installiert' >> ~/Log/settings2pi.log
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
echo "   Wenn Sie möchten, können Sie auf dieser Installation Ihre E-Mail Adresse hinterlegen,"
echo "   sodass Sie vom System Informationen per E-Mail zugesendet bekommen."

echo -n "   Hierzu wird das E-Mail Programm "
echo -n -e "${blaufett}s-nail ${standard}"
echo "installiert."

echo
echo "   Wenn Sie Ihre E-Mail Adresse später hinterlegen möchten sowie weitergehende"
echo "   Informationen finden Sie in der Dokumentation auf github.com/pimanDE/settings2pi"

while ! ((antwortemail)); do
	echo
	echo
   while :; do
        echo
        read -p "   Möchten Sie Ihre E-Mail Adresse im System hinterlegen? [j/N]: " antwort
        case "$antwort" in
	   j)
		antwortemail=1
		echo
		# echo -e "   ${blaufett}E-Mail Adresse wird hinterlegt ...${standard}"
		# sleep 2


        echo -e "${blaufett}   s-nail wird installiert ...${standard}"

        echo
        echo
        sudo apt install -y s-nail

        sudo mv /etc/s-nail.rc /etc/s-nail.rc.orig

        wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Scripte/email-eintragen.sh
        chmod +x email-eintragen.sh
        ./email-eintragen.sh

        # echo "Dieser Text erscheint in der Mail" | s-nail -A MAIL -s "Dieser Text erscheint im Betreff" meine-email@gmx.net

        echo
		echo

		echo '   5. E-Mail Adresse wurde erfolgreich im System hinterlegt.' >> ~/Log/settings2pi.log
		echo
		echo
		echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		echo -e "   + ${gruenfett}5. E-Mail Adresse wurde erfolgreich im System hinterlegt.${standard} +"
		echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		echo
		echo
		sleep 2

	       break
               ;;
           N|n|"")
                antwortemail=2
		echo
		echo

		echo '   5. E-Mail Adresse wurde nicht im System hinterlegt.' >> ~/Log/settings2pi.log
		echo
		echo
		echo "   ++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		echo -e "   + ${gruenfett}5. E-Mail Adresse wurde nicht im System hinterlegt.${standard} +"
		echo "   ++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
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
sleep 2



####################################################################################################################
# Installation von pihole

echo
echo

echo -e "${blaufett}   Installiere pihole ...${standard}"

echo
echo

sudo curl -sSL https://install.pi-hole.net | bash

echo
echo

echo "   Bitte das Passwort für die Weboberfläche ändern! [ENTER] = kein Passwort"

echo
echo

pihole -a -p                                                            # Passwort neu vergeben oder löschen

wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Dateien/pihole/listen-geräte-gruppen-hinzufügen.sh
chmod +x listen-geräte-gruppen-hinzufügen.sh
sudo ./listen-geräte-gruppen-hinzufügen.sh                              # Hinzufügen von Domainen, Gruppen, Blocklisten etc.

sleep 2

echo -e "${blaufett}   Die Blockseite wird angepasst ... ${standard}"
sudo wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Dateien/pihole/blockseite.html -P /var/www/html/pihole
sudo rpl --encoding UTF-8 '/pihole/index.php' '/pihole/blockseite.html' /etc/lighttpd/lighttpd.conf > /dev/null 2>&1
sudo service lighttpd restart

sleep 2

sudo cp /etc/pihole/pihole-FTL.conf /etc/pihole/pihole-FTL.conf.orig

sudo chmod 666 /etc/pihole/pihole-FTL.conf
echo 'BLOCKINGMODE=IP-NODATA-AAAA' >> /etc/pihole/pihole-FTL.conf       # Damit die Blockseite angezeigt wird. ACHTUNG: Nur bei HTTP-Seiten!
echo 'DBINTERVALL=60' >> /etc/pihole/pihole-FTL.conf                    # Schreibvorgänge nur alle 60 Minuten (Standard =1 Minute)
echo 'MAXDBDAYS=60' >> /etc/pihole/pihole-FTL.conf                      # Einträge die älter als 60 Tage sind, werden gelöscht
sudo chmod 664 /etc/pihole/pihole-FTL.conf

sudo systemctl disable systemd-resolved                                 # https://forum.kuketz-blog.de/viewtopic.php?p=85243

sudo touch /etc/dnsmasq.d/10-pihole-extra.conf                          # https://forum.kuketz-blog.de/viewtopic.php?p=85243
sudo chmod 777 /etc/dnsmasq.d/10-pihole-extra.conf
sudo echo 'proxy-dnssec' >> /etc/dnsmasq.d/10-pihole-extra.conf
sudo echo >> /etc/dnsmasq.d/10-pihole-extra.conf
sudo chmod 644 /etc/dnsmasq.d/10-pihole-extra.conf

sudo mv /etc/pihole/setupVars.conf /etc/pihole/setupVars.conf.orig      # Einstellungen für Einstellungen/DNS
sudo wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Dateien/pihole/setupVars.conf -P /etc/pihole
sudo chmod 777 /etc/pihole/setupVars.conf
sudo rpl --encoding UTF-8 "local-ip" $ipadresse /etc/pihole/setupVars.conf > /dev/null 2>&1
sudo chown root:root /etc/pihole/setupVars.conf
sudo chmod 644 /etc/pihole/setupVars.conf

sudo chmod 777 /etc/pihole/dns-servers.conf
sudo echo "Dismail.de (DNS-over-TLS);80.241.218.68;159.69.114.157;" >> /etc/pihole/dns-servers.conf    # Dismail als zusätzliche Alternative
sudo echo "dnsforge.de (DNS-over-TLS);176.9.93.198;176.9.1.117;" >> /etc/pihole/dns-servers.conf       # dnsforge.de als zusätzliche Alternative
sudo chmod 644 /etc/pihole/dns-servers.conf

sudo curl -sSL https://raw.githubusercontent.com/pimanDE/translate2german/master/translate2german.sh | bash     # Übersetzt die Weboberfläche auf deutsch

echo
echo
echo '   6. Pihole wurde erfolgreich installiert' >> ~/Log/settings2pi.log
echo
echo
echo "   +++++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}6. Pihole wurde erfolgreich installiert${standard} +"
echo "   +++++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



####################################################################################################################
# Installation von unbound

echo
echo

echo -e "${blaufett}   Installiere Unbound ...${standard}"

echo
echo

sudo apt install -y unbound

sudo rm /etc/dnsmasq.d/01-pihole.conf
sudo wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Dateien/unbound/01-pihole.conf -P /etc/dnsmasq.d/

sudo wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Dateien/unbound/99-edns.conf -P /etc/dnsmasq.d/   # https://docs.pi-hole.net/guides/dns/unbound/
sudo wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Dateien/unbound/pi-hole.conf -P /etc/unbound/unbound.conf.d/


echo
echo
echo '   7. Unbound wurde erfolgreich installiert und konfiguriert' >> ~/Log/settings2pi.log
echo
echo
echo "   ++++++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}7. Unbound wurde erfolgreich installiert${standard} +"
echo "   ++++++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2


####################################################################################################################
# Willkommensbildschirm installieren

echo
echo

cd ~/Scripte

wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Scripte/install-welcome-screen.sh
wget -q https://raw.githubusercontent.com/pimanDE/settings2pi/master/Scripte/welcome-screen.sh
chmod +x install-welcome-screen.sh
chmod +x welcome-screen.sh

./install-welcome-screen.sh

echo
echo

echo '   8. Willkommensbildschirm erfolgreich installiert.' >> ~/Log/settings2pi.log
echo
echo
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}8. Willkommensbildschirm erfolgreich installiert.${standard} +"
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



####################################################################################################################
# Automatische Aktualisierung des Systems

sudo rpl --encoding UTF-8 'benutzername' $username ~/Scripte/update-and-upgrade.sh > /dev/null 2>&1
sudo rpl --encoding UTF-8 'rechnername' $hostname ~/Scripte/update-and-upgrade.sh > /dev/null 2>&1

sudo rpl --encoding UTF-8 'benutzername' $username ~/Scripte/email-update-and-upgrade.sh > /dev/null 2>&1
sudo rpl --encoding UTF-8 'rechnername' $hostname ~/Scripte/email-update-and-upgrade.sh > /dev/null 2>&1

sudo rpl --encoding UTF-8 'benutzername' $username ~/Scripte/cron/cronjobs.txt > /dev/null 2>&1

# Das System wird zwischen 0 Uhr und 2:59 Uhr aktualisiert
sudo sed -i "s/AB C /$((RANDOM % 60)) $((RANDOM % 3))/" ~/Scripte/cron/cronjobs.txt
sudo sed -i "s/DE F /$((RANDOM % 60)) $((RANDOM % 3))/" ~/Scripte/cron/cronjobs.txt

sudo crontab -u root /home/$username/Scripte/cron/cronjobs.txt

sudo chown root:root /home/$username/Scripte/update-and-upgrade.sh
sudo chmod 554 /home/$username/Scripte/update-and-upgrade.sh
sudo touch /home/$username/Log/update-and-upgrade.log


echo
echo '   9. Automatische Aktualisierung des Systems erfolgreich' >> ~/Log/settings2pi.log
echo
echo
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}9. Automatische Aktualisierung des Systems erfolgreich.${standard} +"
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



####################################################################################################################
# Aliase vergeben

echo "#" > ~/.bash_aliases

echo "alias 'ls=ls -lh --color=auto'" >> ~/.bash_aliases    # aus 'ls -l' wird 'ls'; evtl mit der Option --color=auto
echo "alias 'his=clear && history'" >> ~/.bash_aliases      # listet letzte Befehle auf

echo >> ~/.bash_aliases                                     # Leerzeile einfügen
source ~/.bash_aliases                                      # Konfigurationsdatei neu einlesen

echo '   10. Aliase erfolgreich vergeben' >> ~/Log/settings2pi.log
echo
echo
echo "   ++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}10. Aliase erfolgreich vergeben.${standard} +"
echo "   ++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



####################################################################################################################
# Systemsprache auf deutsch umstellen

echo -e "   ${blaufett}Systemprache wird auf deutsch umgestellt ...${standard}"
echo
echo
sudo rpl --encoding UTF-8 '\# de_DE.UTF-8 UTF-8' 'de_DE.UTF-8 UTF-8' /etc/locale.gen > /dev/null 2>&1
sudo rpl --encoding UTF-8 'LANG=en_GB.UTF-8' 'LANG=de_DE.UTF-8' /etc/default/locale > /dev/null 2>&1
sudo locale-gen

echo '   11. Sprache wurde erfolgreich auf deutsch umgestellt' >> ~/Log/settings2pi.log
echo
echo
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}11. Sprache wurde erfolgreich auf deutsch umgestellt.${standard} +"
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



#####################################################################################################################
# Texteditor Nano konfigurieren

sudo chmod 666 /etc/nanorc
sudo echo 'set constantshow' >> /etc/nanorc				# Zeigt in der Statuszeile die Zeilen- und Spaltennummer an
sudo chmod 644 /etc/nanorc

echo '   12. Texteditor nano wurde erfolgreich konfiguriert' >> ~/Log/settings2pi.log
echo
echo
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "   + ${gruenfett}12. Texteditor nano wurde erfolgreich konfiguriert.${standard} +"
echo "   +++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo
echo
sleep 2



####################################################################################################################
# Nacharbeiten


# Schreibvorgänge des Systems reduzieren
sudo mkdir /etc/systemd/journald.conf.d                                 # https://forum.kuketz-blog.de/viewtopic.php?p=85243
sudo touch /etc/systemd/journald.conf.d/00-volatile-storage.conf
sudo chmod 777 /etc/systemd/journald.conf.d/00-volatile-storage.conf
sudo echo '[Journal]' > /etc/systemd/journald.conf.d/00-volatile-storage.conf
sudo echo 'Storage=volatile' >> /etc/systemd/journald.conf.d/00-volatile-storage.conf
sudo echo 'RuntimeMaxUse=30' >> /etc/systemd/journald.conf.d/00-volatile-storage.conf
sudo echo >> /etc/systemd/journald.conf.d/00-volatile-storage.conf
sudo chmod 644 /etc/systemd/journald.conf.d/00-volatile-storage.conf



# HDMI-Anschluss deaktivieren
#sudo tvservice -o > /dev/null



# Cache leeren
echo -e "   ${blaufett}Aufräumen ...${standard}"
echo
echo
sudo apt clean                  # Leeren des Paketcaches (Entfernen von zur Installation heruntergeladenen Paketen)
sudo apt autoclean              # wie clean, nur werden ausschließlich Pakete, die nicht mehr in den Quellen verfügbar sind, gelöscht
sudo apt autoremove -y          # Deinstallation ungenutzter Abhängigkeiten



# Wlan am Raspberry Pi freischalten
rfkill unblock wifi



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

echo -e "${rotfett}   _______________Hinweis bei ssh-Portänderung______________${standard}"
echo -e "${rotfett}   Login: ssh benutzername@rechner-ip -p neue-ssh-portnummer${standard}"
echo
echo -e "${rotfett}   Beispiel: ssh pimanDE@192.168.178.30 -p 4711${standard}"

echo

echo -e "${rotfett}   ___________________Allgemeiner Hinweis__________________${standard}"
echo -e "${rotfett}   Lesen Sie bitte die Erläuterungen zum Script${standard}"
echo -e "${rotfett}   in der Dokumentation auf github.com/pimanDE/settings2pi.${standard}"

echo
echo


read -p "   Neustart mit ENTER bestätigen ... "
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