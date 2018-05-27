# Einfaches Testscript für portcheck
# Aufruf: ./test.sh "host1 [host2 ... hostn]"

PWD=$(pwd)
NOW=$(date)
BASEDIR=${PWD%test}

# SOURCE_IPs als Parameter holen
SOURCE_LIST=$1

echo "TESTER, Test: $NOW"
echo "***"
echo

# Voraussetzungen auf Source-Hosts testen
echo "Teste Voraussetzungen für jede SOURCE_IP:"
for s in $SOURCE_LIST; do
    echo -n "  $s: "
    ssh $s openssl version
    if [ $? != 0 ]; then
        echo; echo "  Fehler: Anmeldung an Host $s nicht möglich!"; echo
        exit 5
    fi
done
echo

# Parameter für den Test
TARGET_LIST="google.de yahoo.com telekom.de"
PORT_LIST="80 443"

# Aufruf von portcheck *** hier ist der eigentliche Testaufruf ***
$BASEDIR/bin/portcheck.sh "$SOURCE_LIST" "$TARGET_LIST" "$PORT_LIST" 

echo "***"
echo "Test completed!"
exit 0

