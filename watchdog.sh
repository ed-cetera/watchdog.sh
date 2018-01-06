#!/bin/sh

# watchdog.sh
# Copyright (c) 2018 Patrick Rose
#
# See 'README.md' for documentation, see 'LICENSE.md' for licensing.

PGREP=$(which pgrep)
PGREP_OPTIONS="-x"

read -d "" USAGE << EOS
usage: $(basename "$0") [-q|--quiet] watchlist

Bourne Shell script that restarts required processes if necessary.

positional arguments:
  watchlist             list of process names and restart commands

optional arguments:
  -q, --quiet           no output on missing processes
EOS

OUTPUT=true
while [ "$1" = "-q" -o "$1" = "--quiet" ]
do
    OUTPUT=false
    shift 1
done

if [ $# -eq 0 ]
then
    >&2 echo "$USAGE"
    exit 2
fi
if [ -f "$1" ]
then
    while read PROCESS COMMAND
    do
        if [ -n "$PROCESS" -a "$(echo "$PROCESS" | cut -c1)" != "#" ]
        then
            PIDS=$($PGREP $PGREP_OPTIONS $PROCESS)
            if [ -z "$PIDS" ]
            then
                if [ -n "$COMMAND" ]
                then
                    if $OUTPUT
                    then
                        echo "Process '$PROCESS' not running. Restarting."
                    fi
                    $COMMAND &
                elif $OUTPUT
                then
                    echo "Process '$PROCESS' not running."
                fi
            fi
        fi
    done < "$1"
else
    >&2 echo "Watchlist file '$1' not found."
    exit 1
fi
exit 0
