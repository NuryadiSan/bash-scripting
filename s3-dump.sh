#!/bin/bash
 
# AWS Conf
export AWS_ACCESS_KEY_ID="YOUR_AWS_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="YOUR_AWS_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="YOUR_AWS_REGION"
 
# Bucket name file
S3_BUCKET_NAME="your-s3-bucket"
 
# File name on bucket
DUMP_FILE_NAME="your-dump-file.sql"
 
# Connection to db
DB_HOST="your-db-host"
DB_USER="your-db-username"
DB_PASSWORD="your-db-password"
DB_NAME="your-db-name"
 
# unused table to delete
TABLES_TO_DROP=("table1" "table2" "table3")
 
# temporary file storage
TEMP_DUMP_FILE="/tmp/$DUMP_FILE_NAME"
 
# Download file from s3
aws s3 cp s3://$S3_BUCKET_NAME/$DUMP_FILE_NAME $TEMP_DUMP_FILE
 
# restore to new db
mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME < $TEMP_DUMP_FILE
 
# Droping table
for table in "${TABLES_TO_DROP[@]}"
do
    mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -e "DROP TABLE IF EXISTS $table" $DB_NAME
done
 
# Delete temporary dump
rm $TEMP_DUMP_FILE
