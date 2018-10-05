#!/bin/bash

# Named backup file
TIME=`date +%b-%d-%y`

# Definition format backup.
FILENAME=backup-$TIME.tar.gz

# Backup all database mysql
mysqldump --opt -user=root -password=mySuperSecret --all-databases mysql > backup.sql

# create backup folder
sudo mkdir -p /Backup

# Location backup
SRCDIR=/Backup

# Destination backup file.
DESDIR=/Backup/

# Membuat file backup
tar -cpzf $DESDIR/$FILENAME $SRCDIR

# Deleting file on 7 days
#find /backup/  -mtime +7 -type f -delete


#END
