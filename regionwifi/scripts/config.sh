#!/bin/sh

. /koolshare/scripts/base.sh
. /koolshare/scripts/jshn.sh

on_post() {
    local region
    local wifi5g
    local ssid5g

    json_load "$INPUT_JSON"
    json_get_var region "region"
    json_get_var wifi5g "wifi5g"
    json_get_var ssid5g "ssid5g"

    if [ "$region"x == x ]; then
        echo '{"status":"error"}'
    fi
    if [ "$wifi5g" == "enabled" ]; then
        config set wla_ssid=$ssid5g
        config commit
    elif [ "$wifi5g" == "disabled" ]; then
        old=`config get wl_ssid`
        config set wla_ssid=$old
        config commit
    fi

    #NA,WW,GR,PR,RU,BZ,IN,KO,JP,AU,CA
    artmtd -w region $region >/dev/null
    echo '{"status":"ok"}'
}

on_get() {
    region=`artmtd -r region`
    ssid5g=`config get wla_ssid`
    ssid2g=`config get wl_ssid`
    if [ "$ssid5G" = "ssid2g" ]; then
        s5g=5G
        ssid5g=$ssid2g$s5g
    fi
    echo '{"region":"'$region'","ssid5g":"'$ssid5g'"}'
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

