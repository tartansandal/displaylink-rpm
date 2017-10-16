#!/bin/bash

set -e

sudo --validate

make clean
QA_RPATHS=$(( 0x0004 )) make rawhide

new=$(ls -1 x86_64/*.rpm | tail -1)
old=x86_64/$(rpm -q displaylink).rpm

if [[ $new == $old ]]
then
  sudo dnf -y reinstall $new
else
  sudo dnf -y upgrade $new
fi

