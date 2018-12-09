#!/usr/bin/env bash

# USAGE:
# sudo /vagrant/www/scripts/security/audit/rkhunter.sh local


# NOTES:
# http://rkhunter.sourceforge.net/


SERVER_TYPE=$1
PRIVATE_IP=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
TMP_LOG_FILE="/var/log/rkhunter-check-${PRIVATE_IP}-$(date +'%Y-%m-%d-%s').log";


echo "Starting rkhunter update for ${SERVER_TYPE} server ${PRIVATE_IP}.";
sudo rkhunter --versioncheck
sudo rkhunter --update
echo "rkhunter update complete, now scanning ${SERVER_TYPE} server ${PRIVATE_IP}.";
sudo rkhunter --cronjob --report-warnings-only >> ${TMP_LOG_FILE};

#
# * Find errors from temp log file
#
WARNINGS=$(cat "$TMP_LOG_FILE");
#echo ${WARNINGS}


#
# * If there are errors then output to security log
# * https://www.cyberciti.biz/faq/unix-linux-bash-script-check-if-variable-is-empty/
#
if [ ! -z "${WARNINGS}" ]
then
    echo "`date` - Rootkit vulnerabilities found on ${SERVER_TYPE} server ${PRIVATE_IP}" >> /var/log/security.log 2>&1
    cat ${TMP_LOG_FILE} >> /var/log/security.log 2>&1
else
    echo "`date` - Rootkit check okay on ${SERVER_TYPE} server ${PRIVATE_IP}" >> /var/log/security.log 2>&1
fi


#
# Remove temp log file
#
sudo rm ${TMP_LOG_FILE}
echo "Finished rkhunter scan for ${SERVER_TYPE} server ${PRIVATE_IP}.";

