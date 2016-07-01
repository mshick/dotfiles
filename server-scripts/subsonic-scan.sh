#!/usr/bin/env bash

json=$(/usr/local/bin/watchman since '/Volumes/Storage/iTunes/iTunes Media/Music/' n:audio '**/*.m4a' '**/*.mp3')

echo  "[$(date)] Checked for file changes in '/Volumes/Storage/iTunes/iTunes Media/Music/'..."

if [[ $json == *"\"error\": \"unable to resolve root"* ]]
then
	echo "[$(date)] ERROR: Watchman doesn't appear to be watching."
	exit 1
fi

if [[ $json == *"\"files\":"* ]] && [[ $json != *"\"files\": []"* ]]
then
	echo "[$(date)] Found changed files. Refreshing Subsonic database.";
	/usr/bin/curl -d "j_username=admin&j_password=admin&submit=Log in" -c /tmp/subsonic-cookie.txt -s http://localhost:4040/j_acegi_security_check > /dev/null
	/usr/bin/curl -b /tmp/subsonic-cookie.txt -s http://localhost:4040/musicFolderSettings.view?scanNow > /dev/null
fi

