#!/bin/bash

# Stops the script, if an error occurred.
set -e

HOST=$FTP_HOST
USER=$FTP_USER
PASS=$FTP_PASS
TARGETFOLDER=$FTP_TARGET || '/'
SOURCEFOLDER=$FTP_SOURCE || '/'

lftp -e "
set ftp:ssl-auth TLS;
set ftp:ssl-force true;
set ftp:ssl-allow yes;
set ftp:ssl-protect-list yes;
set ftp:ssl-protect-data yes;
set ftp:ssl-protect-fxp yes;
set ssl:verify-certificate yes;
set ssl:ca-file "/root/cert.pem";
set sftp:auto-confirm yes;
open $HOST;
user $USER $PASS;
mirror \
--delete \
--only-newer \
--verbose \
--allow-chown \
--allow-suid \
--no-umask \
--continue \
$SOURCEFOLDER $TARGETFOLDER;
bye;
"
