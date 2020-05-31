#!/usr/bin/env bash

MAILCOW_BACKUP_LOCATION=/opt/mailcow-backup
MAILCOW_BACKUP_SCRIPT=/opt/mailcow-dockerized/helper-scripts/backup_and_restore.sh

USER=root
SYSTEM=localhost

function info { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }

info "Starting SSH backup"

ssh $USER@$SYSTEM 'bash -s' <<EOF
#!/usr/bin/env bash
# create a new backup dir
mkdir -p $MAILCOW_BACKUP_LOCATION
# remove old backups
rm -r $MAILCOW_BACKUP_LOCATION/*
# create the backups using helper script
export MAILCOW_BACKUP_LOCATION=$MAILCOW_BACKUP_LOCATION
$MAILCOW_BACKUP_SCRIPT backup all > /dev/null 2>&1
EOF

info "SSH Backup finished"
info "Copying files"

scp -r $USER@$SYSTEM:$MAILCOW_BACKUP_LOCATION/* .

info "Copying files finished"
info "Removing Mailcow backup from source"

ssh $USER@$SYSTEM 'bash -s' <<EOF
#!/usr/bin/env bash
# remove old backups
rm -r $MAILCOW_BACKUP_LOCATION/*
EOF