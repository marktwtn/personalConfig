#!/bin/bash

set -e

# Variables
home=~
fishFile=${home}/.config/fish/config.fish

# Check whether the file exists or not.
if [ -f ${fishFile} ]; then
    # If it exists, ask the user to replace it or not.
    cat ${fishFile}
else
    # If it does not exist, add the file.
    cp ./config.fish ${fishFile}
fi
