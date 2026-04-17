#!/bin/sh

echo
echo hostname: $(hostname)
. /etc/profile.d/show_product.sh
lscpu | egrep '^Model name'
uname -rvm
cat /proc/cmdline
printf "\n"
cam -l
printf "\n"
v4l2-ctl --list-devices
printf "\n--------------------\n\n"
