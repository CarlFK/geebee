#!/bin/bash -x

# sink client - play mixed audio on local sound hardware

core=${1:-127.0.0.1}
alsa_dev=${2:-hw:1}

exec gst-launch-1.0 \
    tcpclientsrc host=${core} port=11000 !\
    matroskademux !\
    audioconvert !\
    audioresample !\
    alsasink device=${alsa_dev}
