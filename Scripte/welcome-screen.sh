#!/bin/sh
# dynamische MOTD
# Aufruf in /etc/profile (letzte Zeile)


echo
echo


# Datum & Uhrzeit
DATUM=`date +"%A, %d. %B %Y"`
JAHR=`date +"%Y"`                       # 1900
MONAT=`date +"%B"`                      # December
TAG=`date +"%d"`                        # 31
WOCHENTAG=`date +"%A"`                  # Monday



# Hostname
HOSTNAME=`hostname -f`
USERNAME=`whoami`



# Letzter Login
LAST1=`last -2 -F | head -2 | tail -1 | awk '{print $1}'`       # Benutzer (username)
LAST2=`last -2 -F | head -2 | tail -1 | awk '{print $6}'`       # Datum (31)
LAST3=`last -2 -F | head -2 | tail -1 | awk '{print $5}'`       # Monat (12)
LAST4=`last -2 -F | head -2 | tail -1 | awk '{print $8}'`       # Jahr (1900)
LAST5=`last -2 -F | head -2 | tail -1 | awk '{print $7}'`       # Uhrzeit (20:15)
LAST6=`last -2 -F | head -2 | tail -1 | awk '{print $3}'`       # von IP-Adresse (192.168.178.1)
LAST7=`last -2 -d | head -2 | tail -1 | awk '{print $3}'`       # Auflösen der IP-Adresse (PC, iPad etc.)



# Uptime
UP0=`cut -d. -f1 /proc/uptime`
UP1=$(($UP0/86400))                                             # Tage
UP2=$(($UP0/3600%24))                                           # Stunden
UP3=$(($UP0/60%60))                                             # Minuten
UP4=$(($UP0%60))                                                # Sekunden



# Durchschnittliche Auslastung
LOAD1=`cat /proc/loadavg | awk '{print $1}'`		            # Letzte Minuten
LOAD2=`cat /proc/loadavg | awk '{print $2}'`		            # Letzte 5 Minuten
LOAD3=`cat /proc/loadavg | awk '{print $3}'`		            # Letzte 15 Minuten



# Temperatur
TEMP=`vcgencmd measure_temp | cut -c "6-9"`



# Speicherbelegung
DISK1=`df -h | grep 'dev/root' | awk '{print $2}'`              # Gesamtspeicher
DISK2=`df -h | grep 'dev/root' | awk '{print $3}'`              # Belegt
DISK3=`df -h | grep 'dev/root' | awk '{print $4}'`              # Frei



# Arbeitsspeicher
RAM1=`free -h --giga | grep 'Speicher' | awk '{print $2}'`          # Gesamt
RAM2=`free -h --giga | grep 'Speicher' | awk '{print $3}'`          # Benutzt
RAM3=`free -h --giga | grep 'Speicher' | awk '{print $4}'`          # Frei
RAM4=`free -h --giga | grep 'Swap' | awk '{print $3}'`              # Swap benutzt



# IP-Adressen ermitteln
if ( ifconfig | grep -q "eth0" ) ; then IP_LAN=`hostname -I | cut -d" " -f1` ; else IP_LAN="keine IP-Adresse" ; fi ;
if ( ifconfig | grep -q "wlan0" | grep "inet" ) ; then IP_WLAN=`ifconfig wlan0 | grep "inet addr" | cut -d ":" -f 2 | cut -d " " -f 1` ; else IP_WLAN="nicht aktiv" ; fi ;



# Letztes System-Update
SYSTEM_UPDATE1=`tail -1 /home/$USERNAME/Log/update-and-upgrade.log`                    # 01.01.1900 um 12:00:00 Uhr



# Update der Blocklisten
BLOCKLIST_UPDATE1=`stat /etc/pihole/gravity.db | tail -3 | head -1 | awk '{print $2}' | awk -F- '{print $3}'`    # 31.
BLOCKLIST_UPDATE2=`stat /etc/pihole/gravity.db | tail -3 | head -1 | awk '{print $2}' | awk -F- '{print $2}'`    # 12.
BLOCKLIST_UPDATE3=`stat /etc/pihole/gravity.db | tail -3 | head -1 | awk '{print $2}' | awk -F- '{print $1}'`    # 1900
BLOCKLIST_UPDATE4=`stat /etc/pihole/gravity.db | tail -3 | head -1 | awk '{print $3}' | awk -F. '{print $1}'`    # 20:15:00



echo "\033[1;32m                      \033[1;34m$DATUM
\033[1;32m
\033[1;32m     .~~.   .~~.      \033[0;37mRechnername..........: \033[1;30m$HOSTNAME
\033[1;32m    '. \ ' ' /.'      \033[0;37mLetzter Login........: Benutzer $LAST1 am $LAST2. $LAST3. $LAST4 um $LAST5 Uhr von der IP-Adresse $LAST6 ($LAST7)
\033[1;32m    .~ .~~~..~.       \033[0;37mUptime...............: $UP1 Tage, $UP2 Stunden und $UP3 Minuten
\033[1;31m    : .~.'~'.~. :     \033[0;37mØ CPU Auslastung.....: $LOAD1 (1 Min.) | $LOAD2 (5 Min.) | $LOAD3 (15 Min.)
\033[1;31m   ~ (   ) (   ) ~    \033[0;37mTemperatur...........: $TEMP °C
\033[1;31m  ( : '~'.~.'~' : )   \033[0;37mSpeicher (HD)........: Gesamt: $DISK1 | Belegt: $DISK2 | Frei: $DISK3
\033[1;31m   ~ .~ (   ) ~. ~    \033[0;37mSpeicher (RAM).......: Gesamt: $RAM1 | Belegt: $RAM2 | Frei: $RAM3 | Swap: $RAM4
\033[1;31m    (  : '~' :  )     \033[0;37mIP-Adressen..........: LAN: \033[0;37m$IP_LAN\033[0;37m | WLAN: \033[1;35m$IP_WLAN \033[1;35m
\033[1;31m     '~ .~~~. ~'      \033[0;37mUpdate System am.....: \033[0;37m$SYSTEM_UPDATE1
\033[1;31m         '~'          \033[0;37mUpdate Blocklisten am: \033[0;37m$BLOCKLIST_UPDATE1.$BLOCKLIST_UPDATE2.$BLOCKLIST_UPDATE3 um $BLOCKLIST_UPDATE4 Uhr
\033[m"

echo
echo

exit

