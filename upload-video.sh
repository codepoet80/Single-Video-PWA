#!/bin/bash
# This script runs on the OBS computer (or wherever the video originated)
# 	and uploads the most recent recording in a given folder to the server
# Replace the <things> with your values to make it work

server=<YOURSERVER>
videodir="/Users/<YOU>/Movies"
tempfile="/Users/<YOU>/Movies/video.mp4"
remotefile=<YOU>@$server:<YOURPATH>.mp4

# Setup screen
clear
#   Mac only
osascript \
    -e 'tell application "Terminal"' \
    -e 'set position of front window to {40, 40}' \
    -e 'end tell'
echo
echo Video Uploader
echo ==============
echo

# Check Ready
if pgrep "OBS" &> /dev/null; then
    echo OBS is still running, cannot confirm video is ready.
    echo Stop Streaming and Recording, wait for OBS to encode the video, and shutdown OBS.
    echo Then run this script again.
    echo 
    exit
fi
if ping -c 1 $server &> /dev/null; then
    echo Network ready!
else
    echo -e "\033[0;31m*** ERROR ***"
    echo The web server is unreachable!
    echo Check connectivity then run this script again.
    echo -e "\033[0m"
    exit
fi

# Cleanup
sudo killall shutdown &> /dev/null
echo Preparing to upload...
rm -f $tempfile

# Find most recent video
unset -v mp4
for file in $videodir/*.mp4; do
    [[ $file -nt $mp4 ]] && mp4=$file
done
if [ -z "${mp4:-}" ]; then 
    echo "Could not find most recent video!"
    exit
fi
echo Using most recent video: $mp4
echo

# Copy file to temp
yes | cp -rf "$mp4" $tempfile
echo Uploading video...
if [ "$1" = "" ]; then
    echo Computer will shutdown 30 minutes after completion!
fi
echo

# Copy temp file to server
scp $tempfile $remotefile
echo

# Shutdown (if allowed)
if [ "$1" = "" ]; then
    sudo shutdown -h +30
fi

sleep 10
exit
