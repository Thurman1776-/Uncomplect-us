#!/bin/bash
set -euo pipefail

# Comment line above & uncomment line below for debugging
# Print every command before executing it (set -x).
#set -euxo pipefail


if which accio >/dev/null; then
    if which carthage >/dev/null; then
        cd ../Mac-App/Backend
        accio install
    else
        echo "Please install Carthage first"
        echo "https://github.com/Carthage/Carthage"
    fi
else
    echo "Please install Accio first"
    echo "https://github.com/JamitLabs/Accio"
fi
