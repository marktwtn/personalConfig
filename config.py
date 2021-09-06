#!/usr/bin/env python3
import filecmp
import os
import yaml

with open("file.yml", "r") as files:
    data = yaml.load(files, Loader=yaml.FullLoader)

for ele in data:
    print(ele)
    # Get home path
    homePath = os.path.expanduser("~")
    repoConfig = "./" + data[ele]["name"]
    localConfig = homePath + "/" + data[ele]["localPath"] + "/" + data[ele]["name"]
    # Check file existense
    if os.path.isfile(localConfig):
        print("The local configuration file is existed.")
        # Check files difference
        if filecmp.cmp(repoConfig, localConfig, shallow=False):
            print("The files are same.")
        else:
            print("The files are different.")
            # Ask user for next step
            check = input("Do you want to modify the local configuration? (y/n): ")
            if check in ("y", "Y"):
                os.system("vimdiff " + repoConfig + " " + localConfig)
    else:
        print("The local configuration file is not existed.")
        os.system("cp " + repoConfig + " " + localConfig)
        print("Configuration copy is done.")
    print(ele + " configuration is done.\n")
