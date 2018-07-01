#!/bin/sh

. /koolshare/scripts/base.sh
. /koolshare/scripts/jshn.sh

on_post() {
    local region

    json_load "$INPUT_JSON"
    json_get_var region "region"

    #NA,WW,GR,PR,RU,BZ,IN,KO,JP,AU,CA
    artmtd -w region $region

    echo '{"status":"ok"}'
}

on_get() {
    region=`artmtd -r region`
    echo '{"region":"'$region'"}'
}

case $ACTION in
start)
    ;;
post)
    on_post
    ;;
get)
    on_get
    ;;
installed)
    ;;
status)
    ;;
stop)
    ;;
*)
    ;;
esac

