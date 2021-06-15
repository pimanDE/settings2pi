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

echo -e "${blaufett}   Füge erlaubte Domains hinzu ...${standard}"

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

echo -e "${blaufett}   Füge gesperrte Domains hinzu ...${standard}"

# Exakte Blacklist
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (1,'beispiel.com',1,'Beispiel');"


# RegEx Blacklist
## komplette TLD
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.bet$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.casino$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.link$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.porn$',1,'');"

## Ganze Länder
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.ng$',1,'Nigeria');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.ru$',1,'Russland');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.ua$',1,'Ukraine');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'.vn$',1,'Vietnam');"

## Domaingruppen
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[-_.])??adse?rv(er?|ice)?s?[0-9]*[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[-_.])??m?ad[sxv]?[0-9]*[-_.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[-_.])??telemetry[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[-_.])??xn--',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^adim(age|g)s?[0-9]*[-_.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^adtrack(er|ing)?[0-9]*[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^advert(s|is(ing|ements?))?[0-9]*[-_.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^aff(iliat(es?|ion))?[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^analytics?[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^banners?[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^beacons?[0-9]*[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^count(ers?)?[0-9]*[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^pixels?[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^stat(s|istics)?[0-9]*[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^track(ers?|ing)?[0-9]*[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^traff(ic)?[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.adition\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.adscale\.de$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.adup-tech\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.akamai\.net$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.apptimize\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.bild\.de$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.clicktale\.net$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.convertro\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.crashlytics\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.decibelinsight\.net$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.eulerian\.net$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.floryday\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.fullstory\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.gameanalytics\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.hockeyapp\.net$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.hotjar\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.inspectlet\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.internetat\.tv$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.liftoff\.io$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.logrocket\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.luckyorange\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.matchinguu\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.mouseflow\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.myhomescreen\.tv$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.panasonic\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.quantummetric\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.salemove\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.samsungcloudsolution\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.samsungcloudsolution\.net$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.sessioncam\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.smartlook\.com$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.tracking\.i2w\.io$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.userreplay\.net$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^[a-z0-9]+\.yandex\.ru$',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[_.-])?ad[sxv]?[0-9]*[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[_.-])?adse?rv(er?|ice)?s?[0-9]*[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(.+[_.-])?telemetry[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^(www[0-9]*\.)?xn--',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^adim(age|g)s?[0-9]*[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^adtrack(er|ing)?[0-9]*[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^advert(s|is(ing|ements?))?[0-9]*[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^aff(iliat(es?|ion))?[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^analytics?[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^banners?[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^beacons?[0-9]*[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^count(ers?)?[0-9]*[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^mads\.^pixels?[-.]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'^track(ers?|ing)?[0-9]*[_.-]',1,'');"
sudo sqlite3 /etc/pihole/gravity.db "Insert into domainlist (type, domain, enabled, comment) values (3,'(^|\.)partner\.vxcp\.de$',1,'');"



echo -e "${gruenfett}   Erledigt${standard}"
sleep 2


####################################################################################################################
# Hinzufügen der Blocklisten
# github.com/Zelo72/rpi


echo
echo

echo -e "${blaufett}   Füge Blocklisten hinzu ...${standard}"


# Alle Listen Löschen
sudo sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist"


# Eigene Listen
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/Zelo72/rpi/master/pihole/blocklists/multi.txt', 1, 'Zelo72 Multi-Liste');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/Zelo72/rpi/master/pihole/blocklists/fake.txt', 1, 'Zelo72 Fake-Liste');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/Zelo72/rpi/master/pihole/blocklists/privacy.txt', 1, 'Zelo72 Privacy-Liste');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/Zelo72/rpi/master/pihole/blocklists/affiliatetracking.txt', 1, 'Zelo72 Affiliate-Liste');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/Zelo72/rpi/master/pihole/blocklists/cryptoscamdb.txt', 1, 'Zelo72 CryptoScamDB-Liste');"

# Hinzufügen
# sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('file:///home/___user___/Dateien/Liste.txt', 1, 'Beschreibung');"

# alle Listen löschen
# sudo sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist"


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
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO client_by_group (client_id, group_id) VALUES (2, 1);"			# Gerät 3
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO client_by_group (client_id, group_id) VALUES (3, 1);"			# Gerät 3


echo -e "${gruenfett}   Erledigt${standard}"

echo
echo

sleep 5

exit
