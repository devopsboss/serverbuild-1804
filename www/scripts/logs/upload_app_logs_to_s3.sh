#!/usr/bin/env bash

# USAGE
# www/scripts/server/staging/upload_app_logs_to_s3.sh local security-test


if [[ -n "$1" ]]; then
SERVER_NAME=$1
else
    echo "Provide SERVER_NAME eg. local"
    exit
fi

if [[ -n "$2" ]]; then
PROJECT_NAME=$2
else
    echo "Provide PROJECT_NAME eg. security-test"
    exit
fi

#
# * Monitored logs
#
#echo "Upload monitored logs"
BACKUP_LOGS_BUCKET= #TODO: enter bucket name
YEAR=`date "+%Y"`
MONTH=`date "+%m"`
DAY=`date "+%d"`

SUB_DOMAIN=${SERVER_NAME}

# app.error.log
APP_ERROR_LOGS_PATH="${BACKUP_LOGS_BUCKET}/${SERVER_NAME}/${PROJECT_NAME}/app.error.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/serverbuild-1804/projects/${SUB_DOMAIN}/${PROJECT_NAME}/app/logs s3://${APP_ERROR_LOGS_PATH} --recursive --exclude "*" --include "app.error.log*.gz"
rm -rf /var/serverbuild-1804/projects/${SUB_DOMAIN}/${PROJECT_NAME}/app/logs/app.error.log*.gz


