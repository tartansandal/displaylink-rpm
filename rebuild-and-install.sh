#!/bin/bash

set -e

sudo --validate

make clean
make evdi-devel

QA_RPATHS=$(( 0x0004 )) make

sudo dnf -y remove displaylink || true

package=$(ls -1 x86_64/*.rpm | tail -1)
sudo dnf -y install $package

./resign-module.sh

sudo systemctl restart displaylink.service
