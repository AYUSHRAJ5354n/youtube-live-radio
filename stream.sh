#!/bin/bash

set -e

# Start a simple HTTP server for health checks
python3 -m http.server 8080 --bind 0.0.0.0 &

while true
do
  ffmpeg -loglevel info -y -re \
    -f image2 -loop 1 -i Picsart_25-02-17_03-20-47-277.png \
    -f concat -safe 0 -i <((for f in ./mp3/*.mp3; do path="$PWD/$f"; echo "file ${path@Q}"; done) | shuf) \
    -c:v libx264 -preset veryfast -b:v 3000k -maxrate 3000k -bufsize 6000k \
    -framerate 25 -video_size 1280x720 -vf "format=yuv420p" -g 50 -shortest -strict experimental \
    -c:a aac -b:a 128k -ar 44100 \
    -f flv rtmp://a.rtmp.youtube.com/live2/$YOUTUBE_KEY
done
