#!/bin/bash -x

# sink client - display mixed in window on local console

core=${1:-127.0.0.1}

video_sink=${2:-autovideosink}

exec gst-launch-1.0 \
    tcpclientsrc host=${core} port=11000 !\
    matroskademux !\
    videoconvert !\
    ${video_sink}
