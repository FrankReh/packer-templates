#!/bin/sh
PG=postgresql11 PGVer="11.2"
pkg update &&
    pkg upgrade -y &&
    pkg install -y bash vim tmux go &&
    pkg install -y ${PG}-client-${PGVer}   \
                   ${PG}-contrib-${PGVer}  \
                   ${PG}-docs-${PGVer}     \
                   ${PG}-plpython-${PGVer} \
                   ${PG}-server-${PGVer}
