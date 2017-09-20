#!/bin/bash

set -e

# Variables
# home directory
home=~
# File in repository
fishFile=config.fish
vimFile=vimrc
# File in local computer
fishLocFile=${home}/.config/fish/${fishFile}
vimLocFile=${home}/.${vimFile}
# File array
repoList=(${fishFile} ${vimFile})
locList=(${fishLocFile} ${vimLocFile})
# Array length
len=${#repoList[*]}

# Shell script
# Check whether the file exists or not.
for idx in $( seq 0 $(( ${len}-1 )) )
do
    if [ -f ${locList[${idx}]} ]; then
        # If it exists, print the content of the files.
        echo ""
        echo "The content in your computer:"
        echo ""
        echo "********************"
        cat  ${locList[${idx}]}
        echo "********************"
        echo ""
        echo "The content in the repository:"
        echo ""
        echo "********************"
        cat  ${repoList[${idx}]}
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
            cp ${repoList[${idx}]} ${locList[${idx}]}
        fi
    else
        # If it does not exist, copy the file.
        cp ${repoList[${idx}]} ${locList[${idx}]}
    fi
done
