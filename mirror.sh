#!/bin/bash

# Stops the script, if an error occurred.
set -e

TARGETFOLDER=$FTP_TARGET || '/'
SOURCEFOLDER=$FTP_SOURCE || '/'

lftp -d -e "
set ftp:ssl-auth TLS;
set ftp:ssl-force true;
set ftp:ssl-allow yes;
set ftp:ssl-protect-list yes;
set ftp:ssl-protect-data yes;
set ftp:ssl-protect-fxp yes;
set ssl:verify-certificate yes;
set ssl:ca-file "/root/cert.pem";
set sftp:auto-confirm yes;
open $FTP_HOST;
user $FTP_USER $FTP_PASS;
mirror \
--delete \
--only-newer \
--verbose \
--allow-chown \
--allow-suid \
--no-umask \
--continue \
--exclude-glob-from=/root/exclude-glob \
$SOURCEFOLDER $TARGETFOLDER;
bye;
"
# --delete = -e ローカルのファイルを削除したら、FTPサーバー側のファイルも削除 https://symfoware.blog.fc2.com/blog-entry-1840.html
# --only-newer = -n 新しいファイルのみ処理 https://symfoware.blog.fc2.com/blog-entry-1840.html
# -aのオプションを付けると、owner, group, パーミッション を保存したまま同期します（ --allow-chown --allow-suid --no-umask と同じ）。 https://qiita.com/quickguard/items/2f189c8b09d724006fd9
