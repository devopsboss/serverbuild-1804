#!/usr/bin/env bash

# USAGE:
# sudo /vagrant/www/scripts/security/audit/clamscan_antivirus.sh local

# NOTES:
# TODO: test with `clamscan EICAR-AV-Test` (see https://en.wikipedia.org/wiki/EICAR_test_file)
# https://www.howtoforge.com/tutorial/configure-clamav-to-scan-and-notify-virus-and-malware/
# https://www.lisenet.com/2014/automate-clamav-to-perform-daily-system-scan-and-send-email-notifications-on-linux/
# https://help.ubuntu.com/community/ClamAV#Run_ClamAV_as_a_Daemon


# server type eg. prod or staging or local
SERVER_TYPE=$1
PRIVATE_IP=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
TMP_LOG_FILE="/var/log/clamav/clamscan-${PRIVATE_IP}-$(date +'%Y-%m-%d-%s').log";
SCAN_FOLDER="/";


#for S in ${SCAN_FOLDER}; do
#DIRSIZE=$(du -sh "$S" 2>/dev/null | cut -f1);

echo "Starting anti-virus clamscan for ${SERVER_TYPE} server ${PRIVATE_IP}.";

# show date at the top of the log file
#(date +'%Y-%m-%d-%s') >> ${TMP_LOG_FILE};

# Use clamscan to check nearly all files on the computer, and report only warnings and infections:
sudo nice -n5 clamscan -ri ${SCAN_FOLDER} --exclude-dir=/sys/* >> ${TMP_LOG_FILE};

# get the value of "Infected lines"
INFECTED_FILES=$(tail "$TMP_LOG_FILE"|grep Infected|cut -d" " -f3);

# if the value is not equal to zero, add infected files to security log
if [ ${INFECTED_FILES} -ne "0" ];then
    echo "`date` - Malware Found on ${SERVER_TYPE} server ${PRIVATE_IP}" &&  >> /var/log/security.log 2>&1
    cat ${TMP_LOG_FILE} >> /var/log/security.log 2>&1
else
    echo "`date` - Clean clamav on ${SERVER_TYPE} server ${PRIVATE_IP}" &&  >> /var/log/security.log 2>&1
fi


#
# Remove temp log file
#
sudo rm ${TMP_LOG_FILE}
echo "Finished anti-virus clamscan for ${SERVER_TYPE} server ${PRIVATE_IP}.";
