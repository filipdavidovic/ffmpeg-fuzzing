#!/usr/bin/env bash

if [[ $# < 2 ]]; then
    echo "Usage: afl_parallel.sh <worker_id> <path_to_testcases>"
    exit
fi

WORKER_ID=$1
TESTCASES=$2

touch $TESTCASES/../tmp/stdin$WORKER_ID.mmf
FILE=$TESTCASES/../tmp/stdin$WORKER_ID.mmf

if [[ $WORKER_ID == 1 ]]; then
    echo "Starting master"
    afl-fuzz -m 500 -i $TESTCASES \
        -f $FILE \
        -o /vagrant/findings \
        -M fuzzer$WORKER_ID \
        /home/vagrant/bin/bin/ffmpeg -i $FILE /tmp/outfile.mp4
else
    echo "Starting slave"
    afl-fuzz -m 500 -i $TESTCASES \
        -f $FILE \
        -o /vagrant/findings \
        -S fuzzer$WORKER_ID \
        /home/vagrant/bin/bin/ffmpeg -i $FILE /tmp/outfile.mp4
fi