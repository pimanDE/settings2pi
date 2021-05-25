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

`s-nail` ist ein einfacher und schlanker Mailclient. Er soll dazu dienen, dass bei jeder Anmeldung am Raspberry Pi eine kurze Mail als Info geschickt wird. So wird man sofort informiert, wenn ein Login stattfindet. Man benötigt hierzu eine E-Mail Adresse von ([GMX](https://www.gmx.net)). Sicherlich geht es auch mit anderen E-Mail Providern.

Die meisten Einstellungen für `s-nail` sind bereits voreingestellt. Lediglich die dritt-, viert-und fünftvorletzte Zeile der Datei `/etc/s-nail.rc`muss editiert werden. Welche Änderungen dort vorgenommen werden müssen, sind in der Datei selbsterklärend.

```bash
sudo nano +224,20 /etc/s-nail.rc
```

<html><u>Achtung!</u></html> Nach dem Editieren der Datei bitte die entsprechenden Lese- und Schreibrechte setzen:

```bash
sudo chmod 440 /etc/s-nail.rc
```

Ebenso muss noch die Datei `/etc/profile` am Ende editiert werden. Hierbei bitte die voreingetragene E-Mail durch die eigene E-Mail Adresse ersetzen.

```bash
sudo chmod 777 /etc/profile
sudo nano +35,99 /etc/profile
sudo chmod 644 /etc/profile
```

---
**Warum kann s-nail nicht auch automatisch konfiguriert werden?**

`s-nail` könnte natürlich auch so installiert und konfiguriert werden, sodass keine Nacharbeiten erforderlich wären. Dabei müsste jedoch dann während des Scripts die E-Mail Adresse und das Passwort abgefragt werden. Dies soll dem Benutzer nicht abverlangt werden. Jeder soll selber entscheiden, ob er seiner Raspberry Pi Installation das Passwort vom E-Mail Account anvertraut.

---
**Wann wird das System automatisch aktualisiert?**

Das System wird täglich zwischen 0 Uhr und 3:00 Uhr nachts automatisch aktualisiert. Bei der Installation wird diese randomnisiert festgelegt.


---
**Warum ...**

...


---


**Sind Verbesserungsvorschläge und Anregungen erwünscht?**

Ja natürlich. Ich kann jedoch nicht garantieren, ob ich diese dann auch umsetzen kann. Leider ist meine Zeit begrenzt. Ich werden jedoch mein Bestes geben :sunglasses:

---
