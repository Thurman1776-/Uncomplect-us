#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

export SCRIPT_INPUT_FILE_0=${SRCROOT}"/Dependencies/macOS/ReSwift.framework"
export SCRIPT_INPUT_FILE_COUNT=1

/usr/local/bin/carthage copy-frameworks
