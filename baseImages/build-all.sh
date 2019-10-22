#!/bin/bash
CURR_PATH=$(pwd)
THIS_FILENAME=$(basename "$0")

find $CURR_PATH -type f -name 'build*.sh' ! -name $THIS_FILENAME | xargs -I % echo "cd \$(dirname %); ./\$(basename %)" | sh