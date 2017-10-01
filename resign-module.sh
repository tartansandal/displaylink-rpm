#!/bin/bash

set -e

sudo --validate

private_key='/run/media/kal/MyKeys/MOK.priv'
public_key='/run/media/kal/MyKeys/MOK.der'

# if we have just installed a kernel, it may not be the current, so just
# sign everything we can find
for kernel in $(ls -1 /usr/src/kernels)
do
    if [[ -f /lib/modules/$kernel/extra/evdi.ko ]]
    then
        echo signing /lib/modules/$kernel/extra/evdi.ko
        sudo /usr/src/kernels/$kernel/scripts/sign-file sha256 $private_key $public_key \
            /lib/modules/$kernel/extra/evdi.ko
    fi
done
