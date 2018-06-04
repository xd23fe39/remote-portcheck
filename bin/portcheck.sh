# REMOTE PortChecker
# - wird von einem zentralen Rechner installiert und aufgerufen
# - prüft von dort aus alle SourceIP-TargetIP-Port-Kombinationen.
# - erfordert ssh und openssl auf allen Systemen
#
echo "REMOTE PortChecker 2018 xd23fe39"
echo
# SourceIP Schleife
for s in $1; do
    echo "Source IP: $s"
    echo
    echo "Target IP(s):"
    # QuellIP-Schleife
    for i in $2; do
        # Ports-Schleife
        for p in $3; do
            # Aufruf unterstützt z.B. Disconnect-OpenSSL-by-Q, Timeout bei FW-Blocking
            ssh -x $s "((echo Q | timeout 2 openssl s_client -connect $i:$p) > /dev/null 2>&1 )"
            RES=$?
            # Ergebnis interpretieren: 0 = OK, 1=CONNECTION_REFUSED, 124 = CONNECTION_TIMEOUT
            if [ "$RES" == "0" ]; then
                echo "  $i tcp/$p: OK"
            elif [ "$RES" == "1" ]; then
                echo "  $i tcp/$p: WARN=$RES (Connection refused)"
            elif [ "$RES" == "124" ]; then
                echo "  $i tcp/$p: FAIL=$RES (Connection timeout)"
            else
                # FW blockiert oder: unbekannter Fehlercode in $RES
                echo "  $i tcp/$p: FAIL=$RES (Unknown)" 
            fi
        done
    done
    echo
done
echo "Test completed!"
echo
