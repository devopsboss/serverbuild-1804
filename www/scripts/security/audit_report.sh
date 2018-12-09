#!/usr/bin/env bash

# USAGE:
# sudo /vagrant/www/scripts/security/audit/audit_report.sh local


# NOTES:
# http://aureport.sourceforge.net/


SERVER_TYPE=$1
PRIVATE_IP=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
TMP_LOG_FILE="/var/log/audit-report-${PRIVATE_IP}-$(date +'%Y-%m-%d-%s').log";


echo "Starting audit report for ${SERVER_TYPE} server ${PRIVATE_IP}.";
sudo aureport >> ${TMP_LOG_FILE};


#
# * output report to security log
#
cat ${TMP_LOG_FILE} >> /var/log/security.log 2>&1


#
# Remove temp log file
#
sudo rm ${TMP_LOG_FILE}
echo "Finished audit report for ${SERVER_TYPE} server ${PRIVATE_IP}.";
