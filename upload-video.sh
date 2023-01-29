#!/bin/bash
# This script runs on the OBS computer (or wherever the video originated)
# 	and uploads the most recent recording in a given folder to the server
videodir="/Users/<YOU>/Movies"
tempfile="/Users/<YOU>/Movies/video.mp4"
remotefile=<YOU>@<YOURSERVER.COM>:<YOURPATH>.mp4

clear
echo
echo Video Uploader
echo ==============
echo

# Check Ready
if pgrep "OBS" > /dev/null; then
    echo OBS is still running, cannot confirm video is ready.
    echo Stop Streaming and Recording, wait for OBS to encode the video, and shutdown OBS.
    echo Then run this script again.
    echo 
    exit
fi

# Cleanup
echo Preparing to upload...
sudo killall shutdown
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
