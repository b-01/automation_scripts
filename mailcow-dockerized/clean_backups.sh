#!/bin/bash
# Bash script to automatically backup mailcow-dockerized data using the provided helper 
# script "backup_and_restore.sh". Keeps $MAX_BACKUPS on disk.
  
MAX_BACKUPS=4
MAILCOW_BACKUP_LOCATION=/opt/mailcow-backup
MAILCOW_BACKUP_SCRIPT=/opt/mailcow-dockerized/helper-scripts/backup_and_restore.sh

if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# remove old backups if needed
while [ "$(ls -1 $MAILCOW_BACKUP_LOCATION | wc -l)" -ge "${MAX_BACKUPS}" ]
do
  echo "Max backups reached!"
  OLDEST_BACKUP="$(ls -1 $MAILCOW_BACKUP_LOCATION | head -1)"
  echo "Deleting oldest: ${MAILCOW_BACKUP_LOCATION}/${OLDEST_BACKUP}"
  rm -rf ${MAILCOW_BACKUP_LOCATION}/${OLDEST_BACKUP}
done

# create the backups
export MAILCOW_BACKUP_LOCATION
$MAILCOW_BACKUP_SCRIPT backup all

echo "Done!"