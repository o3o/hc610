mkdir -p ./public/js
mkdir -p ./sass

####################
# material-design-icons
####################
mkdir -p ./public/fonts/material
cp -up ~/node_modules/material-design-icons/iconfont/Material* ./public/fonts/material


####################
# materialize
####################
MAT=~/node_modules/materialize-css
cp -rup $MAT/sass/components ./sass
# !! materialize.scss deve essere aggiornato manualmente con meld
#cp -up $MAT/sass/materialize.scss ./sass
cp -rup $MAT/dist/fonts ./public
cp -up $MAT/dist/js/materialize.js ./public/js/

####################
# highchart
# http://www.highcharts.com
####################
HC=~/node_modules/highcharts
cp -up $HC/highcharts.js ./public/js
cp -up $HC/highcharts-more.js ./public/js
cp -up $HC/modules/boost.js ./public/js
cp -up $HC/modules/boost-canvas.js ./public/js
cp -up $HC/modules/exporting.js ./public/js
cp -up $HC/modules/data.js ./public/js
cp -up $HC/modules/solid-gauge.js ./public/js


####################
# jQuery
####################
# prima di installare scaricare
# $ npm install jquery
JQ=~/node_modules/jquery
cp -up $JQ/dist/jquery.min.js ./public/js


