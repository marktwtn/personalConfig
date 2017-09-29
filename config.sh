#!/bin/bash

set -e

# Variables
# home directory
home=~
# File in repository
fishFile=config.fish
vimFile=.vimrc
tmuxFile=.tmux.conf
# File in local computer
fishLocFile=${home}/.config/fish/${fishFile}
vimLocFile=${home}/${vimFile}
tmuxLocFile=${home}/${tmuxFile}
# File array
repoList=(${fishFile} ${vimFile} ${tmuxFile})
locList=(${fishLocFile} ${vimLocFile} ${tmuxLocFile})
# Array length
len=${#repoList[*]}

# Shell script
# Check whether the file exists or not.
for idx in $( seq 0 $(( ${len}-1 )) )
do
    # Print the configuration file name
    printf "\n\e[1;36m"
    printf "${repoList[${idx}]}"
    printf "\n\e[0m"
    if [ -f ${locList[${idx}]} ]; then
        # If it exists, print the content of the files.
        printf "\nThe content in your computer:\n"
        printf "********************\n"
        printf "\e[5;33m"
        cat  ${locList[${idx}]}
        printf "\e[0m"
        printf "********************\n"
        printf ""
        printf "\nThe content in the repository:\n"
        printf "********************\n"
        printf "\e[5;32m"
        cat  ${repoList[${idx}]}
        printf "\e[0m"
        printf "********************\n"
        printf ""
        # Ask the user to replace it or not.
        read -p "Replace the file in your computer or not (y/n): " decision
        while [ ${decision} != 'y' ] && [ ${decision} != 'n' ]
        do
            printf  "Please enter y or n"
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
