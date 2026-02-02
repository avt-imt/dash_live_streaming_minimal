#!/bin/bash

# start web server
python3 -m http.server 8080 &
SERVER_PID=$!

# start streaming
ffmpeg -f v4l2 -framerate 30 -video_size 1280x720 -i /dev/video0 \
-c:v libx264 -b:v 2000k -g 60 -keyint_min 60 \
-f dash -window_size 10 -extra_window_size 5 \
-seg_duration 2 -use_template 1 -use_timeline 0 \
-remove_at_exit 1 ./manifest.mpd


# stop web server
kill $SERVER_PID



