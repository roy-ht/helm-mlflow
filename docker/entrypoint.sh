#!/bin/sh

OPTION_BACKEND_STORE_URI=""
if [ -n "${DB_HOST}" ]; then
    if [ -n "${DB_PASSWORD_FILE}" ]; then
        _pass=`cat ${DB_PASSWORD_FILE}`
        echo "${DB_HOST}:${DB_PORT}:${DB_DATABASE}:${DB_USER}:${_pass}" > ~/.pgpass
        chmod 600 ~/.pgpass
        OPTION_BACKEND_STORE_URI="--backend-store-uri=postgresql://${DB_USER}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"
    elif [ -n "${DB_PASSWORD}"]; then
        OPTION_BACKEND_STORE_URI="--backend-store-uri=postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"
    fi
fi

exec mlflow server --host 0.0.0.0 $OPTION_BACKEND_STORE_URI "$@"