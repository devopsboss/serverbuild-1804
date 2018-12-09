#!/usr/bin/env bash

# USAGE:


# server type eg. prod or staging or local
SERVER_TYPE=$1
PRIVATE_IP=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
TMP_LOG_FILE="/var/log/find_777_files-${PRIVATE_IP}-$(date +'%Y-%m-%d-%s').log";


echo "Starting file & folder permission check for ${SERVER_TYPE} server ${PRIVATE_IP}.";


#
# * FIND 777 FILES & FOLDERS (ignore symlinks)
# * ignore "/proc/*" and "/var/crash/.lock" and "/opt/awscli-bundle/install"
#
#sudo find / -type d -perm 0777 -not -path "/proc/*" -or -type f -perm 0777 -not -path "/proc/*" |grep -vw "/var/crash/.lock"|grep -vw "/opt/awscli-bundle/install"
sudo find / -type d -perm 0777 -not -path "/proc/*" -or -type f -perm 0777 -not -path "/proc/*" |grep -vw "/var/crash/.lock"|grep -vw "/opt/awscli-bundle/install" >> ${TMP_LOG_FILE};

#
# * Set log file as variable
#
FILES_777=$(cat "$TMP_LOG_FILE");

#
# * If there are warnings then output to security log
# * https://www.cyberciti.biz/faq/unix-linux-bash-script-check-if-variable-is-empty/
#
if [ ! -z "${FILES_777}" ];then
    echo "`date` - 777 files found on ${SERVER_TYPE} server ${PRIVATE_IP}" &&  >> /var/log/security.log 2>&1
    echo ${FILES_777} >> /var/log/security.log 2>&1
else
    echo "`date` - File permissions okay okay on ${SERVER_TYPE} server ${PRIVATE_IP}" &&  >> /var/log/security.log 2>&1
fi

#
# Remove temp log file
#
sudo rm ${TMP_LOG_FILE}
echo "Finished file & folder permission check for ${SERVER_TYPE} server ${PRIVATE_IP}.";
