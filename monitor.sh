#!/bin/bash

DIRECTORY="/home/monitor/"

SQL_NAME="proje"
SQL_USERNAME="postgres"
SQL_PASSWORD="0000"
SQL_TABLE="proje"

while true; do
    CHANGES=$(inotifywait -e modify,move,create,delete --format '%w%f %e' -r $DIRECTORY)
    if [ ! -z "$CHANGES" ]; then
        psql -d "$SQL_NAME" -U "$SQL_USERNAME" -c "INSERT INTO $SQL_TABLE (event) VALUES ('$CHANGES');"
        echo $CHANGES >>/home/gbpekalp/Masaüstü/projelog.log
    fi
    sleep 3
done
