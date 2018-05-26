# remote-portcheck

Testet ausgehend von einem zentralen SSH-Host, ob Kommunikationsverbindungen von einer FW blockiert werden oder nicht

Aufruf:

```sh
portcheck SOURCE-IP TARGET-IP PORT
portcheck SOURCE-LIST TARGET-LIST PORT-LIST
```

Anwendungsbeispiel:

```sh
./portcheck.sh syncbox "google.de telekom.de" "80 443"
```
