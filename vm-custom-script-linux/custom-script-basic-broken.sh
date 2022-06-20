#!/bin/bash -e
################################################################################
##  File:   customscript.sh
##  Desc:   Install Microsoft Package Repository.
##          Install tooling: Java, Maven, Docker, Powershell, Ruby, Python
##  Author: Aswin Kandula
################################################################################

#!/bin/bash -e

if [ ! -f "/etc/apt/sources.list.d/microsoft-prod.list" ]; then
    # Install Microsoft repository
    LSB_RELEASE=$(lsb_release -rs)
    wget https://packages.microsoft.com/config/ubuntu/$LSB_RELEASE/packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
fi
if [ ! -f "/etc/apt/trusted.gpg.d/microsoft.gpg" ]; then
    # Install Microsoft GPG public key
    curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
fi
# update
sudo apt-get -y update
# upgrade
# https://github.com/Azure/WALinuxAgent/issues/1565#issuecomment-648480167
sudo apt-mark hold walinuxagent
sudo apt-get -y upgrade
sudo apt-mark unhold walinuxagent

touch /tmp/date.txt
date > /tmp/date.txt

exit 0
