## Erläuterungen zum Script

<br>

**Warum dieses Projekt?**

Der Raspberry Pi ist bei vielen nicht mehr wegzudenken und er erfüllt mittlerweile viele Aufgaben. Er dient häufig als eigene Cloud, als Mailserver oder fungiert als miniDLNA. Hierbei werden am Raspberry Pi im Laufe der Zeit Einstellungen vorgenommen, die sich zum Beispiel beim Defekt der SD-Karte nur mit sehr viel Aufwand wieder herstellen lassen.

Ziel dieses Projektes soll sein, dass sich der Raspberry Pi mit all seinen Einstellungen schnell wieder herstellen lässt.

---
**Warum wird das Programm rpl installiert?**

Während des Scriptes wird einiges ausgetauscht. Hierfür wird das Programm `rpl` benötigt.

---
**Warum wird ein neuer Benutzer hinzugefügt?**

Aus Sicherheitsgründen wird ein neuer Benutzer angelegt und der Standardbenutzer *pi* deaktiviert. Gleichzeitig wird auch zur Sicherheit ein neues Passwort erstellt.

---
**Warum wird der Rechnername geändert?**

Da *raspberrypi* der Standard Rechnername ist, wird auch dieser aus Sicherheitsgründen geändert.

---
**Mir gefällt aber der Name raspberrypi. Muss ich ihn trotzdem ändern?**

Nein. Wenn Sie so sehr daran hängen, können Sie den Rechnernamen beibehalten. Geben Sie bei der Abfrage einfach wieder *raspberrypi* ein. Empfohlen wird dies aber nicht.

---
**Warum wird WLAN Country nicht automatisch auf Deutschland gestellt?**

Dies wird bewusst dem Benutzer überlassen, da einige dies wünschen und andere halt nicht. Möglicherweise wird der Raspberry Pi auch außerhalb von Deutschland betrieben.

---
**Kann ich sofort mit dem zweiten Script beginnen?**

Nein. Im ersten Script werden Vorbereitungen getroffen, die im zweiten Script zwingend benötigt werden.

---
**Welche Einstellungen werden bei der ssh Konfiguration vorgenommen?**

Hierzu gibt es im Script weitergehende Erläuterungen. Weitere Härtegrade werden gerne entgegengenommen :wink:

---
**Ich möchte bei fail2ban im Nachhinein weitere Adressen vom Blocken ausnehmen. Geht das?**

Ja das geht. Hierzu öffnet man die Datei ```/etc/fail2ban/jail.local``` und fügt weitere IP Adressen an der entsprechende Stelle ein.

```bash
sudo nano +54,38 /etc/fail2ban/jail.local
```

---
**Warum wird bei fail2ban nicht das gesamte Hausnetz vom Blocken ausgenommen?**

Kühlschrank, Wischroboter, Waschmaschine, Zahnbürste, Gäste und Nachbarn ...
Heuzutage befindet sich eine Vielzahl an Geräten im eigenen Netzwerk. Hierbei erscheint es sicherer, nur explizit Geräte vom Blocken auszunehmen.

---
**Veracrypt wird installiert. Kann ich damit auch Truecrypt Container einbinden?**

Ja das geht ohne Probleme. Hierzu muss nur der Parameter `--truecrypt` mit angegeben werden. Veracrypt Container werden wie folgt eingebunden:

```bash
veracrypt -m=nokernelcrypto /Quelle /Einhängepunkt
veracrypt -m=nokernelcrypto --truecrypt /Quelle /Einhängepunkt
```

---

**Was ist s-nail und wie aktiviere ich es?**

`s-nail` ist ein einfacher und schlanker Mailclient. Er soll dazu dienen, dass bei jeder Anmeldung am Raspberry Pi eine kurze Mail als Info gesendet wird. So wird man sofort informiert, wenn ein Login stattfindet. Man benötigt hierzu eine E-Mail Adresse von [GMX](https://www.gmx.net). Sicherlich geht es auch mit anderen E-Mail Providern.

Die meisten Einstellungen für `s-nail` sind bereits voreingestellt. Lediglich die dritt-, viert- und fünftvorletzte Zeile der Datei `/etc/s-nail.rc`muss editiert werden. Welche Änderungen dort vorgenommen werden müssen, sind in der Datei selbsterklärend.

```bash
sudo nano +224,20 /etc/s-nail.rc
```

<html><u>Achtung!</u></html> Nach dem Editieren der Datei bitte die entsprechenden Lese- und Schreibrechte setzen:

```bash
sudo chmod 400 /etc/s-nail.rc
```

Ebenso muss noch die Datei `/etc/profile` am Ende editiert werden. Hierbei bitte die voreingetragene E-Mail durch die eigene E-Mail Adresse ersetzen.

```bash
sudo chmod 777 /etc/profile
sudo nano +35,99 /etc/profile
sudo chmod 644 /etc/profile
```

---
**Warum kann s-nail nicht auch automatisch konfiguriert werden?**

`s-nail` könnte natürlich auch so installiert und konfiguriert werden, sodass keine Nacharbeiten erforderlich wären. Dabei müsste jedoch dann während des Scripts die E-Mail Adresse und das Passwort abgefragt werden. Dies soll dem Benutzer nicht abverlangt werden. Jeder soll selber entscheiden, ob er seinem Raspberry Pi das Passwort vom E-Mail Account anvertraut.

---
**Wann wird das System automatisch aktualisiert?**

Das System wird täglich zwischen 0 Uhr und 3:00 Uhr automatisch aktualisiert (`~/Scripte/update-and-upgrade.sh`).
Ebenso wird alle drei Monate die `root.hints` für `unbound` zwischen 0 Uhr und 3:00 Uhr automatisch aktualisiert (`~/Scripte/update-root-nameserver.sh`).

Bei der Installation werden die Uhrzeiten randomnisiert festgelegt.
Ob die Aktualisierung erfolgreich war, kann im Verzeichnis `~/Log` geprüft werden.

Wenn die automatischen Aktualisierungen nicht durchgeführt werden konnten, können Sie darüber eine Mail erhalten.
Hierzu müssen Sie folgende Dateien editieren. Hierbei bitte die voreingetragene E-Mail durch die eigene E-Mail Adresse ersetzen.

```bash
sudo chmod 777 ~/Scripte/update*.sh
sudo nano +17,270 ~/Scripte/update-and-upgrade.sh
sudo nano +21,270 ~/Scripte/update-root-nameserver.sh
sudo chmod 554 ~/Scripte/update*.sh
```

Bei der Aktualisierung der `root.hints` wird in jedem Fall eine E-Mail versendet.

---
**Warum wird der HDMI-Anschluss deaktiviert?**

Der Grundgedanke dieses Scriptes ist, dass kein zusätzlicher Monitor benötigt wird. Daher lag es nahe, den Ansschluss zu deaktivieren.
Immer nach dem Motto: Was nicht benötigt wird, ist nicht vorhanden.


---


**Ich möchte aber einen Monitor anschließen. Wie kann ich den HDMI-Anschluss wieder aktivieren?**

Der HDMI-Anschluss wird folgendermaßen mit den Standard Einstellungen wieder aktiviert:
```bash
sudo tvservice -p
```
Zur Kontrolle:

```bash
sudo tvservice -status
```


---


**Warum wurde im pihole die Blockingpage geändert**

Die Anzeige der mofifizierten Blockingpage signalisiert dem Benutzer eindeutig, dass die Seite gesperrt ist.


---



**Ich möchte aber die Original Blockingpage haben. Geht das?**

Ja, das geht. Folgende zwei Befehle sind hierzu erforderlich:
```bash
sudo rpl '/pihole/blockseite.html' '/pihole/index.php' /etc/lighttpd/lighttpd.conf > /dev/null 2>&1
sudo service lighttpd restart
```


---



**Muss ich noch etwas im pihole einstellen?**

Dem Grunde nach sollte pihole anstandslos funktionieren. Unter Einstellungen/DNS kann unten noch die Bedingte Weiterleitung aktiviert werden. Weitere Informationen sind unter [docs.pi-hole.net](https://docs.pi-hole.net/routers/fritzbox-de/) am Ende der Seite zu finden.


---


**Warum ...**

...


---


**Warum ...**

...


---





**Sind Verbesserungsvorschläge und Anregungen erwünscht?**

Ja natürlich. Ich kann jedoch nicht garantieren, ob ich diese dann auch umsetzen kann. Leider ist meine Zeit begrenzt. Ich werde jedoch mein Bestes geben :sunglasses:

---
