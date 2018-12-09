#!/usr/bin/env bash

# USAGE:
# sudo /vagrant/www/scripts/security/audit/fail2ban_status.sh local


SERVER_TYPE=$1
PRIVATE_IP=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
TMP_LOG_FILE="/var/log/fail2ban-status-${PRIVATE_IP}-$(date +'%Y-%m-%d-%s').log";


#sudo fail2ban-client status


#
# TODO: fail2ban status of modsec-bad_user_agent jail
#
echo "(if installed) Checking fail2ban status of modsec-bad_user_agent jail for ${SERVER_TYPE} server ${PRIVATE_IP}.";
#sudo fail2ban-client status modsec-bad_user_agent >> ${TMP_LOG_FILE};


#
# fail2ban status of sshd jail
#
echo "Checking fail2ban status of sshd jail for system ${PRIVATE_IP}.";
sudo fail2ban-client status sshd >> ${TMP_LOG_FILE};


FAILED=$(cat "$TMP_LOG_FILE"|grep "Total failed");
BANNED=$(cat "$TMP_LOG_FILE"|grep "Total banned");


#
# * If there are failed attempts then output to security log
# * https://www.cyberciti.biz/faq/unix-linux-bash-script-check-if-variable-is-empty/
#
if [ ! -z "${FAILED}" ]
then
    echo "`date` - fail2ban total failed attempts found on ${SERVER_TYPE} server ${PRIVATE_IP}" >> /var/log/security.log 2>&1
    cat ${TMP_LOG_FILE} >> /var/log/security.log 2>&1
else
    #
    # * If there are errors then output to security log
    # * https://www.cyberciti.biz/faq/unix-linux-bash-script-check-if-variable-is-empty/
    #
    if [ ! -z "${BANNED}" ]
    then
        echo "`date` - fail2ban no failed attempts, but there are banned ips on ${SERVER_TYPE} server ${PRIVATE_IP}" >> /var/log/security.log 2>&1
        cat ${TMP_LOG_FILE} >> /var/log/security.log 2>&1
    else
        echo "`date` - fail2ban okay (no failed attempts or banned ips) on ${SERVER_TYPE} server ${PRIVATE_IP}" >> /var/log/security.log 2>&1
    fi
fi


#
# Remove temp log file
#
sudo rm ${TMP_LOG_FILE}
echo "Finished fail2ban status of sshd jail for ${SERVER_TYPE} server ${PRIVATE_IP}.";
