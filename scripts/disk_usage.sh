#!/bin/sh
# set -x

########################## SOURCE #########################################
# http://www.cyberciti.biz/tips/shell-script-to-watch-the-disk-space.html #
###########################################################################

# Shell script to monitor or watch the disk space
# It will send an e-mail to $EMAIL, if the (free available) percentage of space is >= $ALERT_LEVEL.
# -------------------------------------------------------------------------
# Set e-mail
EMAIL=""
# set alert level (percentage)
ALERT_LEVEL=80
# Exclude list of unwanted monitoring, if several partions then use "|" to separate the partitions.
# An example: EXCLUDE_LIST="/dev/hdd1|/dev/hdc5"
EXCLUDE_LIST="/mnt"
#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#

main_prog () {
    while read output;
    do
      usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
      partition=$(echo $output | awk '{print $2}')
      #echo $output, $usep, $partition
      if [ $usep -ge $ALERT_LEVEL ] ; then
         echo "Running out of space \"${partition} (${usep}%)\" on server $(hostname), $(date)"
         echo "Running out of space \"${partition} (${usep}%)\" on server $(hostname), $(date)" | \
         mail -s "Alert: disk space usage ${usep}%" $EMAIL
      fi
    done
}

if [ "$EXCLUDE_LIST" != "" ] ; then
  df -H | grep -vE "^Filesystem|tmpfs|cdrom|${EXCLUDE_LIST}" | awk '{print $5 " " $6}' | main_prog
else
  df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}' | main_prog
fi

