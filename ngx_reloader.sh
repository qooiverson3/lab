#!/bin/bash

function reload () {
    nginx -s reload
}

function pre_check () {
    nginx -t
}

function rollback () {

    reload
}

function backup () {
    cp
}

function log () {
    echo "[`date --iso-8601=seconds`] $1"
    sleep 0.2s
}

function init () {

}

function main () {
    log "waiting for warn-up for 1m.."
    sleep 1m
    log "reloader is running.."

    while true; do
        for conf in `cat configs`; do
            last_modified=`stat -c %Y ${CONFIG_FILES}`

            current_modified=`stat -c %Y ${CONFIG_FILES}`

            if [ $current_modified -gt $last_modified ];then
                folder=`date +%Y.%m.%d.%H.%M.%S`

                mkdir $folder
                if [ $? != 0 ];then
                    log "initial folder failed.."
                fi


                backup
            fi
        done
    sleep 1s
    done
}

main
