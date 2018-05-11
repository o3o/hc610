# Egon
Progetto di interfaccia web per calorimetro.

## Commesse
- V16072CR Calorimetro Secop

## Installazione dipendenze del progetto

Il modo più semplice è:
```
$ ./init
```
Per la creazione e l'installazione del progetto vedere `git@gitlab.com:o3o_tex/appunti-vibed.git`.

## Clonare i file di configurazione
Ciascun progetto ha dei file di configurazione opportuni
```
$ cd egon/config
$ git clone -o gt gitea@192.168.221.249:Microline/v17018-config.git
$ cd ..
$ echo config/v17018-config >> .gitignore  //una sola volta!
```

## Come compilare
- Impostare `config.json`
- Assicurarsi che redis sia avviato
- `dub build` oppure `dubbio`

## Come eseguire i test
- Assicurarsi che redis sia avviato
- `dub test` oppure `dubbio -t`

## Creare un  release
```
./release.sh
```
è creato il file egon-versione.tar.bz2

## Come installare
Siccome alyx usa postgresql è necessaria libpq
```
$ yaourt -Qi postgresql-libs
$ yaourt -Sy libevent
```

Per usare **ldc** installare
```
$ yaourt -Sy liblphobos
```
`openssl-1.0` **non** è più necessario dopo l'inserimento dell'opzione in dub.sdl:

```
versions "VibeUseOpenSSL11"
```

## Note
### Collegare la rete
```
ip addr add 192.168.222.64/24 dev enp3s0
```

### Script in js
E' consigliato inserire gli script a fine pagina per non rallentare la visualizzazione (cioe' alla fine di layout.dt): cosi' facendo pero'
lo script `connect()` non funziona perche' inserito (in index) prima della definizione.

Due soluzioni:
- 1. mettere la definizione degli scripts nell'intestazione di layout.dt
- 2. caricare lo script connect con `body(onload='connect(page)')` in layout.dt, cosi facendo pero' e' necessario passare ad ogni pagina la variabile `page` con il nome della pagina

Il nome della pagina e' passato a `getWS` (in `web`) che lo usa per ottenere le variabili da visualizzare in quella pagina.
Per ora (2016-07-30) si usa il metodo 1

### Script per i grafici
Gli script che definiscono i grafici devono essere nella pagina in cui e' presente il grafico e non in altre.
Per questo motivo non devono essere compilati insieme agli altri script (con output `public/js/egon.js`) ma tenuti separati e caricati nella pagina opportuna.

### Uso di nustache
In `mustache/cops` e' presente un applicativo in D che crea il file `view/cop.dt` a partire da `view/cop.mustache`.

## Riferimenti
- [appunti vibed](git@gitlab.com:o3o_tex/appunti-vibed.git)
- [udp_struct](git@gitlab.com:o3o_d/udp_struct.git) Esempio di conversione di blob in strutture
- [i18n forum](http://forum.rejectedsoftware.com/groups/rejectedsoftware.vibed/thread/20314/)
