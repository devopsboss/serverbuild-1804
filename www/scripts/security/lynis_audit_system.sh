#!/usr/bin/env sh

# USAGE:
# sudo /vagrant/www/scripts/security/audit/lynis_audit_system.sh local

# NOTES:
# https://cisofy.com/documentation/lynis/
# https://www.digitalocean.com/community/tutorials/how-to-perform-security-audits-with-lynis-on-ubuntu-16-04

# server type eg. prod or staging
SERVER_TYPE=$1
PRIVATE_IP=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
TMP_LOG_FILE="/var/log/lynis-result-${PRIVATE_IP}-$(date +'%Y-%m-%d-%s').log";


echo "Starting lynis audit for ${SERVER_TYPE} server ${PRIVATE_IP}.";


#
# * Audit system with Lynis
#
sudo lynis audit system --quiet --no-colors >> ${TMP_LOG_FILE};


#
# * Find warnings from temp log file 
# * Ignore reboot password protect & 2 nameservers
#
WARNINGS=$(cat "$TMP_LOG_FILE"|grep -v "Checking for password protection"|grep -v "Minimal of 2 responsive nameservers"|grep "WARNING");
#WARNINGS=$(tail "$TMP_LOG_FILE"|grep "WARNING");


#
# * If there are warnings then output to security log
# * https://www.cyberciti.biz/faq/unix-linux-bash-script-check-if-variable-is-empty/
#
if [ ! -z "${WARNINGS}" ];then
    echo "`date` - Lynis warning found on ${SERVER_TYPE} server ${PRIVATE_IP}" &&  >> /var/log/security.log 2>&1
    echo ${WARNINGS} >> /var/log/security.log 2>&1
else
    echo "`date` - Lynis audit okay on ${SERVER_TYPE} server ${PRIVATE_IP}" &&  >> /var/log/security.log 2>&1
fi


#
# Remove temp log file
#
sudo rm ${TMP_LOG_FILE}
echo "Finished lynis audit for ${SERVER_TYPE} server ${PRIVATE_IP}.";
