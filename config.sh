#!/bin/bash

set -e

# Variables
home=~
fishFile=${home}/.config/fish/config.fish

# Check whether the file exists or not.
if [ -f ${fishFile} ]; then
    # If it exists, print the content of the files.
    echo ""
    echo "The content in your computer:"
    echo ""
    echo "********************"
    cat  ${fishFile}
    echo "********************"
    echo ""
    echo "The content in the repository:"
    echo ""
    echo "********************"
    cat  ./config.fish
    echo "********************"
    echo ""
    # Ask the user to replace it or not.
    read -p "Replace the file in your computer or not (y/n): " decision
    while [ ${decision} != 'y' ] && [ ${decision} != 'n' ]
    do
        echo    "Please enter y or n"
        read -p "Replace the file in your computer or not (y/n): " decision
    done
    # Do the things according to the answer of the user
    if [ ${decision} == 'y' ]; then
        cp ./config.fish ${fishFile}
    fi
else
    # If it does not exist, copy the file.
    cp ./config.fish ${fishFile}
fi
