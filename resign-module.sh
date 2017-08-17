#!/bin/bash

set -e

sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 ~/.MOK.priv ~/.MOK.der \
    /lib/modules/$(uname -r)/extra/evdi.ko
