#!/bin/bash

set -e

sudo --validate

make clean
QA_RPATHS=$(( 0x0004 )) make rawhide

sudo dnf -y remove displaylink || true

package=$(ls -1 x86_64/*.rpm | tail -1)
sudo dnf -y install $package

./resign-module.sh

sudo systemctl restart displaylink.service
