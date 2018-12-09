#!/usr/bin/env bash

# USAGE:
# sudo /vagrant/www/scripts/security/audit/composer_checker.sh local


# NOTES:
# https://github.com/sensiolabs/security-checker


SERVER_TYPE=$1
PRIVATE_IP=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
TMP_LOG_FILE="/var/log/composer-check-${PRIVATE_IP}-$(date +'%Y-%m-%d-%s').log";


echo "Starting composer check for ${SERVER_TYPE} server ${PRIVATE_IP}.";


#TODO: set remote file based on SERVER_TYPE
#
# * Run security checker
#
sudo /usr/local/bin/security-checker security:check /srv/devopsboss/devopshome/composer.lock >> ${TMP_LOG_FILE};


#
# * Find errors from temp log file
#
ERRORS=$(cat "$TMP_LOG_FILE"|grep ERROR);
#echo ${ERRORS}


#
# * If there are errors then output to security log
# * https://www.cyberciti.biz/faq/unix-linux-bash-script-check-if-variable-is-empty/
#
if [ ! -z "${ERRORS}" ]
then
    echo "`date` - Composer vulnerabilities found on ${SERVER_TYPE} server ${PRIVATE_IP}" >> /var/log/security.log 2>&1
    cat ${TMP_LOG_FILE} >> /var/log/security.log 2>&1
else
    echo "`date` - Composer check okay on ${SERVER_TYPE} server ${PRIVATE_IP}" >> /var/log/security.log 2>&1
fi

#
# Remove temp log file
#
sudo rm ${TMP_LOG_FILE}
echo "Finished composer check for ${SERVER_TYPE} server ${PRIVATE_IP}.";
