#!/usr/bin/env sh
set -vx

term_handler() {
    if [ $PID -ne 0 ]; then
        echo "SIGTERM; passthrough to pid=$PID"
        kill -TERM "$PID"
        wait "$PID"
    fi
    exit 143;
}

if [ "x$URL" = 'x' ];
then
    echo "URL is not defined or is empty"
    exit 1
fi
if [ "x$WALLET_ADDRESS" = 'x' ];
then
    echo "WALLET_ADDRESS is not defined or is empty"
    exit 1
fi

PID=0
PASSWORD=${PASSWORD:-x}
CUSTOM_DIFF=${CUSTOM_DIFF:-5000}

trap 'kill ${!}; term_handler' TERM

./app -o $URL -u $WALLET_ADDRESS -p $PASSWORD --custom-diff=$CUSTOM_DIFF --bind=0.0.0.0:10010 --donate-level=1 --no-color --background

PID=$(pidof app)

while true
do
    tail -f /dev/null & wait ${!}
done


