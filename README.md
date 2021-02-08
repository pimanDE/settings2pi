# settings2pi

<center>

[![Stars](https://img.shields.io/github/stars/pimande/settings2pi?style=flat&label=Stars&color=brightgreen)](https://github.com/pimanDE/settings2pi/stargazers) [![Conributors](https://img.shields.io/github/contributors/pimande/settings2pi?style=flat&label=Mitwirkende&color=brightgreen)](https://github.com/pimanDE/settings2pi/graphs/contributors) [![GitHub Last Commit](https://img.shields.io/github/last-commit/pimanDE/settings2pi?style=flat&label=Letzte%20Änderung&color=brightgreen)](https://github.com/pimanDE/settings2pi/commit/master) [![Forks](https://img.shields.io/github/forks/pimande/settings2pi?style=flat&label=Forks&color=blue)](https://github.com/pimanDE/settings2pi/network/members) [![Issues](https://img.shields.io/github/issues/pimande/settings2pi?style=flat&label=Issues&color=yellow)](https://github.com/pimanDE/settings2pi/issues) [![PullRequests](https://img.shields.io/github/issues-pr/pimande/settings2pi?style=flat&label=Pull%20Requests&color=yellow)](https://github.com/pimanDE/settings2pi/pulls) [![License](https://img.shields.io/github/license/pimanDE/settings2pi?style=flat&label=Lizenz&color=1abc9c)](https://github.com/pimanDE/settings2pi/blob/master/LICENSE)

</center>
<br>

## Automatische Installationen und Einstellungen am Raspberry Pi


<br>

Mit diesem Installations- und Konfigurationsscript sollen Programme auf dem Raspberry Pi im 'Handumdrehen' installiert und mit den persönlichen Einstellungen versehen werden.

Es wird versucht, dass der Benutzer so wenig wie möglich von Hand eingeben muss. Dies kann (z.Zt.) nur über zwei Scripte erfolgen, da einige Einstellungen einen _**reboot**_ erfordern.

Daher muss das **Script** [_`preparations2pi.sh`_](https://raw.githubusercontent.com/pimanDE/settings2pi/master/preparations2pi.sh) (siehe Installationsanleitung) als **erstes** ausgeführt werden.

Hierbei wird


- ein neuer Benutzer angelegt (Benutzer pi wird deaktiviert)
- der Rechnername geändert (bei Bedarf; empfohlen)
- die Sprache wird auf deutsch gestellt
- die Zeitzone wird auf Berlin/Europa gestellt
- WLAN Country wird auf Deutschland gestellt (bei Bedarf)
- zum Schluss der Raspberry Pi neu gestartet

---

Anschließend wird das **(zweite) Script** [_`settings2pi.sh`_](https://raw.githubusercontent.com/pimanDE/settings2pi/master/settings2pi.sh) (siehe Installationsanleitung) ausgeführt.

Mit diesem Script werden die folgende Einstellungen am Raspberry Pi automatisiert vorgenommen:


- das System wird auf den aktuellen Stand gebracht
- Installation diverser Systemprogramme
- ssh wird gehärtet
- fail2ban wird installiert und konfiguriert
- s-nail wird installiert und konfiguriert ([siehe Erläuterungen zum Script](https://github.com/pimanDE/settings2pi/blob/master/Dokumentation/Erläuterungen%20zum%20Script.md))
- ...

<br>
<br>

**Bevor Sie mit den Scripten beginnen:**

- haben Sie ein Backup von Ihrem System gemacht,
- haben Sie sich vom Quellcode überzeugt,
- haben Sie die ([die Erläuterungen zum Script](https://raw.githubusercontent.com/pimanDE/settings2pi/master/Dokumentation/Erläuterungen%20zum%20Script.md)) gelesen,
- haben Sie den Haftungsausschluss gelesen und akzeptiert,
- wissen Sie, dass Sie alles auf eigene Gefahr tun,
- wissen Sie, dass pimanDE alles nach bestem Wissen und Gewissen gemacht hat,
- kennen Sie die IP-Adresse Ihres Computers, von dem Sie sich aus (immer) am Raspberry Pi anmelden (wird im Laufe des zweiten Scripts benötigt)
- ...

<br>
<br>

**Installationsanleitung:**

Wer schnell und bequem loslegen möchte, kann die Scripte mit den folgenden Befehlen in der richtigen Reihefolge nach starten:

---
Script 1:
```bash
bash -c "$(curl -sSL https://raw.githubusercontent.com/pimanDE/settings2pi/master/preparations2pi.sh)"
```
---
Script 2:
```bash
bash -c "$(curl -sSL https://raw.githubusercontent.com/pimanDE/settings2pi/master/settings2pi.sh)"
```

---

Alternativ können die Scripte auch folgendermaßen ausgeführt werden:

```bash
wget https://raw.githubusercontent.com/pimanDE/settings2pi/master/preparations2pi.sh
chmod 775 preparations2pi.sh

wget https://raw.githubusercontent.com/pimanDE/settings2pi/master/settings2pi.sh
chmod 775 settings2pi.sh

./preparation2pi.sh
./settings2pi.sh
```

<br>
<br>

**Hinweise:**

- Dieses Script eignet sich nur für User, die ausschließlich per _**ssh**_ auf dem Raspberry arbeiten
- ein grafisches Login wird nach Ausführen des Scripts nicht mehr möglich sein, da der HDMI-Anschluss deaktiviert wird
- gestet unter Raspberry Pi OS Lite Release vom 11. Januar 2021 ([Download](https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-01-12/2021-01-11-raspios-buster-armhf-lite.zip))
- ...

<br>
<br>

**Zusammenfassung:**

1. [Raspbian OS Lite Image](https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-01-12/2021-01-11-raspios-buster-armhf-lite.zip) auf eine SD Karte schreiben
2. System starten und als user *pi* anmelden
4. Script 1 [(preparation2pi.sh](https://raw.githubusercontent.com/pimanDE/settings2pi/master/preparation2pi.sh)) ausführen
5. Script 2 [(settings2pi.sh](https://raw.githubusercontent.com/pimanDE/settings2pi/master/settings2pi.sh)) ausführen

<br>
<br>

**ToDo:**

- ~~den Rechnernamen ändern~~
- ~~neuen Benutzer erstellen~~
- ~~die Sprache und lokalen Einstellungen auf deutsch ändern~~
- ~~die Zeitzone auf Berlin/Europa ändern~~
- ~~WLAN-Land ändern (nach Auswahl)~~
---
- ~~System auf den aktuellen Stand bringen~~
- ~~ssh härten~~
- ~~fail2ban installieren und konfigurieren~~
- ~~s-nail installieren und konfigurieren~~
- automatische Updates einspielen
- Willkommens Bildschirm erstellen
- Aliase vergeben
- HDMI-Anschluss deaktivieren
- Erstellen von diversen Scripten für automatische Arbeiten
- die Firewall aktivieren
- pi-hole installieren und konfigurieren
- unbound installieren und konfigurieren
- Port Knocking
- Farbe des Prompts ändern
- Texteditor Nano konfigurieren
- Konfiguration der /etc/sudoers (immer nach dem root Passwort fragen)
- System aufräumen
- ...
- ...

<br>
<br>

**Haftungsausschluss**

DIE HIER ANGEBOTENEN SCRIPTE WERDEN OHNE JEDE AUSDRÜCKLICHE ODER IMPLIZIERTE GARANTIE BEREITGESTELLT, EINSCHLIEẞLICH DER GARANTIE ZUR BENUTZUNG FÜR DEN VORGESEHENEN ODER EINEM BESTIMMTEN ZWECK SOWIE JEGLICHER RECHTSVERLETZUNG, JEDOCH NICHT DARAUF BESCHRÄNKT. IN KEINEM FALL IST/SIND DER/DIE AUTOR/EN ODER COPYRIGHTINHABER FÜR JEGLICHEN SCHADEN ODER SONSTIGE ANSPRÜCHE HAFTBAR ZU MACHEN, OB INFOLGE DER ERFÜLLUNG EINES VERTRAGES, EINES DELIKTES ODER ANDERS IM ZUSAMMENHANG MIT DER SOFTWARE ODER SONSTIGER VERWENDUNG DER SOFTWARE ENTSTANDEN.

<br>
<br>

**Abschließend**

Wenn Sie einen Fehler gefunden haben oder der Meinung sind, die ein oder andere Scriptergänzung könnte auf ein breites Interesse stoßen, dann scheuen Sie sich nicht, ein [Issue](https://github.com/login?return_to=https%3A%2F%2Fgithub.com%2FpimanDE%2Fsettings2pi%2Fissues%2Fnew) zu eröffnen.

[![Iliked](https://img.shields.io/badge/Star-Wenn%20Ihnen%20das%20Projekt%20gefällt-%23FF0000.svg?&style=flat&label=Star&color=brightgreen)](https://github.com/login?return_to=%2FpimanDE%2Fsettings2pi) [![Iwillfork](https://img.shields.io/badge/Fork-Wenn%20Sie%20es%20interessant%20finden-%23FF0000.svg?&style=flat&label=Fork&color=blue)](https://github.com/login?return_to=https%3A%2F%2Fgithub.com%2FpimanDE%2Fsettings2pi%2Ffork) [![New Issue](https://img.shields.io/badge/Query-Wenn%20Sie%20Fragen%20haben-%23FF0000.svg?&style=flat&label=Query&color=orange)](https://github.com/login?return_to=https%3A%2F%2Fgithub.com%2FpimanDE%2Fsettings2pi%2Fissues%2Fnew)
