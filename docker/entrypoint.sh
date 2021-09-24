#!/bin/sh

OPTION_BACKEND_STORE_URI=""
if [ -n "${DB_ENABLED}" ]; then
    _DB_PASS="${DB_PASSWORD}"
    if [ -n "${DB_PASSWORD_FILE}" ]; then
        _DB_PASS="`cat ${DB_PASSWORD_FILE}`"
    fi
    OPTION_BACKEND_STORE_URI="--backend-store-uri='postgresql://${DB_USER}:${_DB_PASS}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}'"
fi

OPTION_PORT="--port=80"
if [ -n "${MLFLOW_PORT}" ]; then
    OPTION_PORT="--port=${MLFLOW_PORT}"
fi

exec mlflow server --host 0.0.0.0 $OPTION_PORT $OPTION_BACKEND_STORE_URI "$@"