#!/bin/bash
#
# Konfigurieren von Pi-hole
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
# Hinzufügen von erlaubten Domains


echo
echo

echo -e "${blaufett}   Füge zu erlaubende Domains hinzu ...${standard}"

# Exakte Whitelist
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (0,'beispiel.com',1,'Beispiel');"


# RegEx Whitelist
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (2,'(\.|^)github\.com$',1,'Github.com');"


echo -e "${gruenfett}   Erledigt${standard}"
sleep 2



####################################################################################################################
# Hinzufügen von gesperrten Domains


echo
echo

echo -e "${blaufett}   Füge zu sperrende Domains hinzu ...${standard}"

# Exakte Blacklist
# sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (1,'beispiel.com',1,'Beispiel');"



# RegEx Blacklist
## Ganze Länder
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.am$',1,'Domains aus Armenien');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.bd$',1,'Domains aus Bangladesch');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.cd$',1,'Domains aus der Republik Kongo');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.cf$',1,'Domains aus Zentralafrikanische Republik');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.cm$',1,'Domains aus Kamerun');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.cn$',1,'Domains aus China');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.ga$',1,'Domains aus Gabun');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.gq$',1,'Domains aus Äquatorialguinea');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.ke$',1,'Domains aus Kenia');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.kr$',1,'Domains aus Südkorea');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.kp$',1,'Domains aus Nordkorea');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.ml$',1,'Domains aus Mali');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.ng$',1,'Domains aus Nigeria');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.pw$',1,'Domains aus Palau');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.ru$',1,'Domains aus Russland');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.su$',1,'Domains aus der Sowjetunion');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.tk$',1,'Domains aus Tokelau');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.ua$',1,'Domains aus der Ukraine');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.vn$',1,'Domains aus Vietnam');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.ws$',1,'Domains aus Samoa');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.zw$',1,'Domains aus Simbawe');"

# RegEx Blacklist
## komplette TLD
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.adult$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.asia$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.bar$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.best$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.bet$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.bid$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.cam$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.casa$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.casino$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.club$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.cyou$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.date$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.email$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.icu$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.link$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.poker$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.porn$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.quest$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.rest$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.sbs$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.sex$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.sexyn$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.stream$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.support$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.surf$',1,'TLDs mit hoher Rate bösartiger Adressen)');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.tokyo$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.top$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.uno$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.webcam$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.win$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.work$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.xxx$',1,'TLDs mit hoher Rate bösartiger Adressen');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.xyz$',1,'TLDs mit hoher Rate bösartiger Adressen');"

# RegEx Blacklist
## Domaingruppen
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[-_.])??adse?rv(er?|ice)?s?[0-9]*[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[-_.])??m?ad[sxv]?[0-9]*[-_.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[-_.])??telemetry[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^adim(age|g)s?[0-9]*[-_.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^adtrack(er|ing)?[0-9]*[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^advert(s|is(ing|ements?))?[0-9]*[-_.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^aff(iliat(es?|ion))?[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^analytics?[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^banners?[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^beacons?[0-9]*[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^count(ers?)?[0-9]*[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^pixels?[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^stat(s|istics)?[0-9]*[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^track(ers?|ing)?[0-9]*[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^traff(ic)?[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.adition\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.adscale\.de$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.adup-tech\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.akamai\.net$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.apptimize\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.bild\.de$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.clicktale\.net$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.convertro\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.crashlytics\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.decibelinsight\.net$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.eulerian\.net$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.floryday\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.fullstory\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.gameanalytics\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.hockeyapp\.net$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.hotjar\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.inspectlet\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.internetat\.tv$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.liftoff\.io$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.logrocket\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.luckyorange\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.matchinguu\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.mouseflow\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.myhomescreen\.tv$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.panasonic\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.quantummetric\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.salemove\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.samsungcloudsolution\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.samsungcloudsolution\.net$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.sessioncam\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.smartlook\.com$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.tracking\.i2w\.io$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.userreplay\.net$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.yandex\.ru$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[_.-])?ad[sxv]?[0-9]*[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[_.-])?adse?rv(er?|ice)?s?[0-9]*[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[_.-])?telemetry[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^adim(age|g)s?[0-9]*[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^adtrack(er|ing)?[0-9]*[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^advert(s|is(ing|ements?))?[0-9]*[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^aff(iliat(es?|ion))?[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^analytics?[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^banners?[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^beacons?[0-9]*[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^count(ers?)?[0-9]*[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^mads\.^pixels?[-.]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^track(ers?|ing)?[0-9]*[_.-]',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'(^|\.)partner\.vxcp\.de$',1,'Tracking, Pishing and Malware');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.*(xn--).*',1,'Punycode');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'watson\..*\.microsoft.com',1,'Windows Telemetry');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^wpad\.',1,'WPAD Protokoll im Netzwerk verbieten');"





echo -e "${gruenfett}   Erledigt${standard}"
sleep 2


####################################################################################################################
# Hinzufügen der Blocklisten


echo
echo

echo -e "${blaufett}   Füge Blockierlisten hinzu ...${standard}"


# Alle Listen Löschen
sudo sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist"


# Eigene Listen
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/ultimate.txt', 1, 'Aggressive Protection');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt', 1, 'Threat Intelligence Feeds - Increases Security Significantly!');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/doh-vpn-proxy-bypass.txt', 1, 'DoH/VPN/TOR/Proxy Bypass - Prevent methods to bypass your DNS!');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/xRuffKez/NRD/main/nrd-14day_adblock.txt', 1, 'Domains jünger als 14 Tage');"


# Hinzufügen
# sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('file:///home/___user___/Dateien/Liste.txt', 1, 'Beschreibung');"



# Listen aktualisieren
pihole -g


echo -e "${gruenfett}   Erledigt${standard}"
sleep 2


####################################################################################################################
# Geräte hinzufügen


echo
echo
echo -e "${blaufett}   Füge Geräte hinzu ... ${standard}"


# sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO client (id, ip, comment) VALUES (1, '192.168.178.21', 'Gerät 1');"
# sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO client (id, ip, comment) VALUES (2, '192.168.178.22', 'Gerät 2');"
# sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO client (id, ip, comment) VALUES (3, '192.168.178.23', 'Gerät 3');"


echo -e "${gruenfett}   Erledigt${standard}"
sleep 2


####################################################################################################################
# Gruppen hinzufügen


echo
echo
echo -e "${blaufett}   Füge Gruppen hinzu ... ${standard}"


sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (enabled, name, description) values (1, 'AWG', 'Alles Wird Geblockt');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (enabled, name, description) values (1, 'AWE', 'Alles Wird Erlaubt');"


echo -e "${gruenfett}   Erledigt${standard}"
sleep 2


####################################################################################################################
# Den Geräten Gruppen zuweisen
# Gruppe Standard:	ID=0
# Gruppe AWG: 		ID=1


echo
echo
echo -e "${blaufett}   Füge Geräte den Gruppen hinzu ... ${standard}"


# sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO client_by_group (client_id, group_id) VALUES (?, 0);"		# Standard Gruppe bereits allen zugewiesen
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO client_by_group (client_id, group_id) VALUES (1, 1);"			# Gerät 1
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO client_by_group (client_id, group_id) VALUES (2, 1);"			# Gerät 2
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO client_by_group (client_id, group_id) VALUES (3, 1);"			# Gerät 3


echo -e "${gruenfett}   Erledigt${standard}"

echo
echo

sleep 5

exit
