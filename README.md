# PORTCHECKER `portcheck.sh`

Getestet wurde das Skript für Linux (RHEL, Debian, Ubuntu).

Ausgehend von entfernten SSH-Host(s) wird getestet, ob Kommunikationsverbindungen von diesen Source-Hosts aus zu den angegebenen Ziel-Hosts möglich sind. Dabei werden **alle** Kombinationen getestet, also S\*T\*P Testaufrufe durchgeführt. Geprüft wird, ob eine FW die Kommunikationsverbindungen blockiert (FAIL) oder nicht (OK).

Voraussetzung ist, das eine ssh-Verbindung zu den Source-Hosts möglich ist und dort openssl installiert ist. Testen läst sich das via `ssh source-host openssl version`.

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

Voraussetzungen testen:

```sh
ssh source-host openssl version
```
