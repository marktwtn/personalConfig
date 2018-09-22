#!/bin/bash

# Variables
# home directory
home=~
# File in repository
fishFile=config.fish
vimFile=.vimrc
tmuxFile=.tmux.conf
gitFile=.gitconfig
# File in local computer
fishLocFile=${home}/.config/fish/${fishFile}
vimLocFile=${home}/${vimFile}
tmuxLocFile=${home}/${tmuxFile}
gitLocFile=${home}/${gitFile}
# File array
repoList=(${fishFile} ${vimFile} ${tmuxFile} ${gitFile})
locList=(${fishLocFile} ${vimLocFile} ${tmuxLocFile} ${gitLocFile})
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
    # Check the files are the same or not
    diff ${locList[${idx}]} ${repoList[${idx}]} > /dev/null
    compare=$?
    if [ -f ${locList[${idx}]} ] && [ "${compare}" != "0" ]; then
        # If it exists, use 'vimdiff' to allow the user to change the files manually.
        vimdiff ${repoList[${idx}]} ${locList[${idx}]}
        printf "\nThe files of "
        printf "\e[1;36m"
        printf "${repoList[${idx}]}"
        printf "\e[0m"
        printf " have difference.\n"
    elif [ "${compare}" == "0" ]; then
        printf "\nThe files of "
        printf "\e[1;36m"
        printf "${repoList[${idx}]}"
        printf "\e[0m"
        printf " have no difference.\n"
    else
        # If it does not exist, copy the file.
        cp ${repoList[${idx}]} ${locList[${idx}]}
    fi
    printf "${repoList[${idx}]} - done\n"
done
