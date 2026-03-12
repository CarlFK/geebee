#!/bin/sh

set -efux

server=$1

username=videoteam

# echo base>/etc/hostname

apt install -y ssh-import-id pmount gnupg

cd /home/${username}

apt install -y git
# git clone https://github.com/CarlFK/voctomix-outcasts

wget https://raw.githubusercontent.com/CarlFK/video-stack-bin-chicken/master/scripts/setup/xfer/xfer.sh
chown videoteam: xfer.sh
chmod u+x xfer.sh

# server=veyepar.NextDayVideo.com
unset lc2_url
/tmp/late_command.sh ${server}
