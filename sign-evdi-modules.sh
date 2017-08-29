#!/bin/bash

# sample script for signing modules evid modules rebuild by dkms

if [[ -f /root/.MOK.priv &&  /root/.MOK.dir ]]
then

    /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 \
        /root/.MOK.priv /root/.MOK.der \
        /lib/modules/$(uname -r)/extra/evdi.ko
fi

exit 0
