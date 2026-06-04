#!/bin/bash -ex

vocto_host=${1:-blue}
vocto_user=videoteam

pub_host=veyepar.nextdayvideo.com
pub_user=videoteam
pub_path=/srv/www/temp/geebee/${vocto_host}

src=${vocto_user}@${vocto_host}
dst=${pub_user}@${pub_host}:${pub_path}


stub="etc/voctomix"
fn="*"
scp ${src}:/${stub}/${fn} ${dst}/${stub}

stub="etc/systemd/system"
fn="videoteam-*"
scp ${src}:/${stub}/${fn} ${dst}/${stub}

stub="home/videoteam/voctomix-outcasts"
fn=record-mixed-av.sh
scp ${src}:/${stub}/${fn} ${dst}/${stub}
fn=generate-cut-list.py
scp ${src}:/${stub}/${fn} ${dst}/${stub}
fn=voctocore-cmds.py
scp ${src}:/${stub}/${fn} ${dst}/${stub}


echo https://${pub_host}:/temp/geebee/${vocto_host}
