#!/bin/bash

DIRECTORY="/home/monitor/"

SQL_NAME="temp"
SQL_USERNAME="root"
SQL_PASSWORD="password"
SQL_TABLE="temp"

while true; do
    CHANGES=$(inotifywait -e modify,move,create,delete --format '%w%f %e' -r $DIRECTORY)
    if [ ! -z "$CHANGES" ]; then
        psql -d "$SQL_NAME" -U "$SQL_USERNAME" -c "INSERT INTO $SQL_TABLE (event) VALUES ('$CHANGES');"
    fi
    sleep 10
done
