#!/bin/sh

route_list="
prophet
"
# /static/index.html
# /

for route in $route_list
do
    base_url="http://localhost:5000"
    url="${base_url}/${route}"
    echo "# <<<<< $url >>>>> #"
    curl $url
    echo
done
