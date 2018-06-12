#!/bin/bash
#
# REMOTE PortChecker
# - wird von einem zentralen Rechner installiert und aufgerufen
# - prüft von dort aus alle SourceIP-TargetIP-Port-Kombinationen.
# - erfordert ssh und openssl auf allen Clients (Source-IP-Systemen)
#
echo "REMOTE PortChecker 2018 xd23fe39"
# Zähler
let POS=0 
let WARN=0
let FAIL=0
let OK=0
# SourceIP Schleife
for s in $1; do
    echo "Source IP: $s"
    echo
    echo "Target IP(s):"
    # QuellIP-Schleife
    for i in $2; do
        # Ports-Schleife
        for p in $3; do
            # Testbefehl, enthält diverse Tricks wie z.B. Disconnect-OpenSSL, Timeout bei FW-Blocking (Stealth-Mode)
            ssh -x $s "((echo Q | timeout 2 openssl s_client -connect $i:$p) > /dev/null 2>&1 )"
            RES=$?
            let POS++
            # 0 = OK, 1=CONNECTION_REFUSED, 124 = TIMEOUT
            if [ "$RES" == "0" ]; then
                echo "  $i tcp/$p: OK"
                let OK++
            elif [ "$RES" == "1" ]; then
                echo "  $i tcp/$p: WARN=$RES (Connection refused)"
                let WARN++
            elif [ "$RES" == "124" ]; then
                echo "  $i tcp/$p: FAIL=$RES (Connection timeout)"
                let FAIL++
            else
                # FW blockiert oder: unbekannter Fehlercode in $RES
                echo "  $i tcp/$p: FAIL=$RES (Unknown)" 
            fi
        done
    done
    echo "  ---"; echo "  Getestet=$POS: OK=$OK WARN=$WARN FAIL=$FAIL";echo
done
echo "  Getestet:       $POS"
echo "  Erfolgreich:    $OK"
echo "  Warnungen:      $WARN"
echo "  Fehler:         $FAIL"
echo
echo "Test completed!"
echo
