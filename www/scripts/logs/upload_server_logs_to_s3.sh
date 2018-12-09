#!/usr/bin/env bash

# USAGE
# www/scripts/server/staging/upload_server_logs_to_s3.sh s3-bucket-name staging
# www/scripts/server/staging/upload_server_logs_to_s3.sh s3-bucket-name prod

#
# * SERVER LOGS
#
LOGS_BUCKET= #TODO: enter name of bucket
YEAR=`date "+%Y"`
MONTH=`date "+%m"`
DAY=`date "+%d"`


if [[ -n "$1" ]]; then
LOGS_BUCKET=$1
else
    echo "Provide LOGS_BUCKET eg. s3-bucket-name"
    exit
fi


if [[ -n "$2" ]]; then
SERVER_NAME=$2
else
    echo "Provide SERVER_NAME eg. local"
    exit
fi



# apache access logs
APACHE_ACCESS_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/apache/access/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log/apache2 s3://${APACHE_ACCESS_LOGS_PATH} --recursive --exclude "*" --include "*access.log*.gz"
sudo rm -rf /var/log/apache2/*access.log*.gz

# apache error logs
APACHE_ERROR_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/apache/error/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log/apache2 s3://${APACHE_ERROR_LOGS_PATH} --recursive --exclude "*" --include "*error.log*.gz"
sudo rm -rf /var/log/apache2/*error.log*.gz


# alternatives.log
ALTERNATIVES_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/alternatives.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log s3://${ALTERNATIVES_LOGS_PATH} --recursive --exclude "*" --include "alternatives.log*.gz"
sudo rm -rf /var/log/alternatives.log*.gz

# auth.log
AUTH_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/auth.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log s3://${AUTH_LOGS_PATH} --recursive --exclude "*" --include "auth.log*.gz"
sudo rm -rf /var/log/auth.log*.gz

# apt/history.log
APT_HISTORY_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/apt/history.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log/apt s3://${APT_HISTORY_LOGS_PATH} --recursive --exclude "*" --include "history.log*.gz"
sudo rm -rf /var/log/apt/history.log*.gz

# apt/term.log
APT_TERM_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/apt/term.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log/apt s3://${APT_TERM_LOGS_PATH} --recursive --exclude "*" --include "term.log*.gz"
sudo rm -rf /var/log/apt/term

# audit.log
AUDIT_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/audit/audit.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log/audit s3://${AUDIT_LOGS_PATH} --recursive --exclude "*" --include "audit.log*.gz"
sudo rm -rf /var/log/audit/audit.log*.gz

# clamav/clamav.log
CLAMAV_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/clamav/clamav.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log/clamav s3://${CLAMAV_LOGS_PATH} --recursive --exclude "*" --include "clamav.log*.gz"
sudo rm -rf /var/log/clamav/clamav.log*.gz

# clamav/freshclam.log
FRESHCLAM_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/clamav/freshclam.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log/clamav s3://${FRESHCLAM_LOGS_PATH} --recursive --exclude "*" --include "freshclam.log*.gz"
sudo rm -rf /var/log/clamav/freshclam.log*.gz

# cron.d.log
CRON_D_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/cron.d.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log s3://${CRON_D_LOGS_PATH} --recursive --exclude "*" --include "cron.d.log*.gz"
sudo rm -rf /var/log/cron.d.log*.gz

# dpkg.log
DPKG_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/dpkg.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log s3://${DPKG_LOGS_PATH} --recursive --exclude "*" --include "dpkg.log*.gz"
sudo rm -rf /var/log/dpkg.log*.gz

# fail2ban.log
FAIL2BAN_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/fail2ban.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log s3://${FAIL2BAN_LOGS_PATH} --recursive --exclude "*" --include "fail2ban.log*.gz"
sudo rm -rf /var/log/fail2ban.log*.gz

# kern.log
KERN_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/kern.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log s3://${KERN_LOGS_PATH} --recursive --exclude "*" --include "kern.log*.gz"
sudo rm -rf /var/log/kern.log*.gz

# mongodb/mongodb.log
MONGODB_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/mongodb/mongodb.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log/mongodb s3://${MONGODB_LOGS_PATH} --recursive --exclude "*" --include "mongodb.log*.gz"
sudo rm -rf /var/log/mongodb/mongodb.log*.gz

# mysql/error.log
MYSQL_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/mysql/error.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log/mysql s3://${MYSQL_LOGS_PATH} --recursive --exclude "*" --include "error.log*.gz"
sudo rm -rf /var/log/mysql/error.log*.gz

# php7.2-fpm.log
PHP_FPM_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/php7.2-fpm.log/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log s3://${PHP_FPM_LOGS_PATH} --recursive --exclude "*" --include "php7.2-fpm.log*.gz"
sudo rm -rf /var/log/php7.2-fpm.log*.gz

# security
SECURITY_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/security/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log s3://${SECURITY_PATH} --recursive --exclude "*" --include "security*.gz"
sudo rm -rf /var/log/security*.gz

# syslog
SYSLOG_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/syslog/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log s3://${SYSLOG_PATH} --recursive --exclude "*" --include "syslog*.gz"
sudo rm -rf /var/log/syslog*.gz

# all other var logs
VAR_LOGS_PATH="${LOGS_BUCKET}/${SERVER_NAME}/server/all-other-var-logs/${YEAR}/${MONTH}/${DAY}"
/usr/local/bin/aws s3 cp /var/log s3://${VAR_LOGS_PATH} --recursive --exclude "*" --include "*.gz"
sudo rm -rf /var/log/*.gz
