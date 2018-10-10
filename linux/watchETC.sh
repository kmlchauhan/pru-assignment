#!/bin/bash

INOTIFY_AVAILABLE=`which inotifywait`
WATCHDIR=~/watchdir
LOGFILE=~/watchETCLog.txt

if [ -z ${INOTIFY_AVAILABLE} ]; then
  sudo yum --enablerepo=epel install -y inotify-tools
else
  echo "inotifywait is most likely installed"
fi

while : ; do
   inotifywait ${WATCHDIR} | while read path action file; do
      ts=$(date +"%C%y%m%d%H%M%S")
         echo "${ts} :: file: ${file} :: ${action} :: ${path}" >> ${LOGFILE}
   done
done
exit 0

