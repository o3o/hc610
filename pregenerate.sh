# Script richiamato da DUB per generare i file di supporto

mkdir -p public/js
mkdir -p public/css
mkdir -p public/locale

## javascript
uglifyjs -b -o public/js/egon.js js/egon.js
#uglifyjs -b -o public/js/chart.js js/chart.js
## sass
sass sass/materialize.scss > public/css/materialize.css

