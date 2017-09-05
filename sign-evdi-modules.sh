#!/bin/bash

# sample script for signing modules evid modules rebuild by dkms

{
/usr/bin/zenity --info --height=100 --width=400 --text \
"The next dialog will ask you to select a key for signing the newly built EVDI modules.

This must be the private key and have a .priv extension. The public key must be in the same directory and have a .der extension.

If these keys are on a USB drive, you should insert and mount that drive
before continuing.

If these keys are encrypted, you will need to decrypt them before continuing."

private_key=$(
    /usr/bin/zenity --file-selection \
                    --title="Select your private key for EVDI module signing" \
                    --file-filter="*.priv"
    )

} 2>/dev/null # ignore the Gtk tranisent parent warning

if [[ -n $private_key ]]
then
    public_key=${private_key%.priv}.der

    if [[ -f $public_key && -f $private_key ]]
    then

        # if we have just installed a kernel, it may not be the current, so just
        # sign everything we can find
        for kernels in $(ls -1 /usr/src/kernels)
        do
        echo    /usr/src/kernels/$kernel/scripts/sign-file sha256 $private_key $public_key \
                /lib/modules/$kernel/extra/evdi.ko
        done
    else
        echo "ERROR could not find module signing key-pair:"
        echo "   $public_key"
        echo "   $private_key"
        exit 1
    fi
else
    echo "ERROR no module signing key selected"
    exit 1
fi

exit 0
