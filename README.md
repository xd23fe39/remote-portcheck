# PORTCHECKER `portcheck.sh`

Getestet wurde das Skript für Linux (RHEL, Debian, Ubuntu).

Ausgehend von entfernten SSH-Host(s) wird getestet, ob Kommunikationsverbindungen von diesen Source-Hosts aus zu den angegebenen Ziel-Hosts möglich sind. Dabei werden **alle** Kombinationen getestet, also S\*T\*P tests durchgeführt. Geprüft wird, ob eine FW die Kommunikationsverbindungen blockiert (FAIL) oder nicht (OK).

Aufruf:

```sh
portcheck SOURCE-IP TARGET-IP PORT
portcheck SOURCE-LIST TARGET-LIST PORT-LIST
```

Anwendungsbeispiel:

```sh
./portcheck.sh syncbox "google.de telekom.de" "80 443"
./portcheck.sh syncbox "google.de telekom.de" "993 25 587 465"
```
