#!/bin/bash

# Stops the script, if an error occurred.
set -e

TARGETFOLDER=$FTP_TARGET || '/'
SOURCEFOLDER=$FTP_SOURCE || '/'

lftp -d -f /root/lftp-conf
