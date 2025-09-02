# I-See-You
ISeeYou è uno strumento Bash e Javascript per individuare la posizione esatta degli utenti durante attacchi di ingegneria sociale o phishing. 
Utilizzando le coordinate esatte della posizione, un aggressore può effettuare una ricognizione preliminare che lo aiuterà a sferrare ulteriori attacchi mirati.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
I-See-You.sh è una versione migliorata del programma originale sviluppato da Viral Maniar e patchato da DanyBit. 
https://github.com/Viralmaniar/I-See-You
Questa versione utilizza Cloudflared per creare un tunnel sicuro verso il server PHP locale, sostituendo i metodi precedenti ormai obsoleti.
Il programma permette di testare funzionalità di geolocalizzazione su dispositivi desktop e mobile, con gestione separata dei permessi e dei messaggi di errore.

## Funzionalità principali

1. Avvio del server PHP locale
   * Server PHP sulla porta 8080.
   * Log delle richieste salvati in `php_server.log`.

2. Tunnel pubblico con Cloudflared
   * Espone il server locale su un URL temporaneo e pubblico.
   * Permette di testare le pagine su più dispositivi senza configurazioni complesse.

3. Geolocalizzazione dell’utente
   * Rilevamento GPS tramite JavaScript, con supporto desktop e mobile.
   * Dati salvati in `coords.log`.
   * Funzionamento desktop invariato, mobile ottimizzato con `enableHighAccuracy` e messaggi di errore visibili.

4. Pagine HTML personalizzabili
   * Nella cartella `html_samples` ci sono esempi di pagine che possono essere integrate in `I-See-You.sh`.
   * Permettono di modificare l’aspetto della pagina visualizzata senza alterare la funzione principale.

5. Gestione log PHP
   * `logme.php` registra tutte le richieste e scrive le coordinate in `coords.log`.
   * I log servono solo per test interni.

---

## Struttura dei file
`I-See-You.sh` – script principale.
`index.html` – pagina HTML con geolocalizzazione.
`logme.php` – script PHP per registrare coordinate.
`coords.log` – log delle coordinate rilevate (solo per test).
`php_server.log` – log del server PHP.
`html_samples/` – esempi di pagine HTML personalizzabili.

---

## Avvertenze legali
- L’uso del software per raccogliere dati di terzi senza consenso è illegale secondo il Codice Penale italiano (articoli 615-ter e 167) e il GDPR europeo (Regolamento UE 2016/679).
- Il programma è destinato solo a test, formazione o scopi di sicurezza su sistemi propri.
- Non distribuire l’URL pubblico generato e usare i dati in `coords.log` solo per test interni.

---

## Note aggiuntive

* La funzione di geolocalizzazione è ottimizzata per dispositivi mobili e desktop.
* Gli esempi HTML in `html_samples` possono essere sostituiti senza modificare la logica principale.
* I log di PHP (`php_server.log`) e le coordinate (`coords.log`) sono separati per una gestione ordinata delle informazioni.

