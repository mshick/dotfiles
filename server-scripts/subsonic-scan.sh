#!/usr/bin/env bash

json=$(/usr/local/bin/watchman since '/Volumes/Storage/iTunes/iTunes Media/Music/' n:audio '**/*.m4a' '**/*.mp3')

echo  "[$(date)] Checked for file changes in '/Volumes/Storage/iTunes/iTunes Media/Music/'..."

if [[ $json == *"\"error\": \"unable to resolve root"* ]]
then
	echo "[$(date)] ERROR: Watchman doesn't appear to be watching. Attemping to restart..."
	launchctl unload ~/Library/LaunchAgents/com.github.facebook.watchman.plist
	launchctl load -w ~/Library/LaunchAgents/com.github.facebook.watchman.plist
	exit 1
fi

if [[ $json == *"\"files\":"* ]] && [[ $json != *"\"files\": []"* ]]
then
	echo "[$(date)] Found changed files. Refreshing Subsonic database.";
	/usr/bin/curl --silent "http://localhost:4040/rest/startScan?u=admin&p=admin&f=json&c=watchman&v=1.15.0" > /dev/null
fi
