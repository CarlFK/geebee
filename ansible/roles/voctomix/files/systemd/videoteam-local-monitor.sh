#!/bin/bash -x

# sink client - display mixed in window on local console

core=127.0.0.1

exec gst-launch-1.0 \
    tcpclientsrc host=${core} port=11000 !\
    matroskademux !\
    videoconvert !\
    xvimagesink

    # waylandsink sync=false

