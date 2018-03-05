#!/bin/bash

## Update packages
apt update && apt upgrade -y && apt install -y curl gpg ca-certificates tar dirmngr
## Check if binaries are already installed
cd ~
if [ ! -f ~/dogecoin-bin/bin/dogecoind ]; then
    curl -o dogecoin.tar.gz -Lk https://github.com/dogecoin/dogecoin/releases/download/v1.10.0/dogecoin-1.10.0-linux64.tar.gz
    if [ $? -eq 0 ]; then
        tar -xvf dogecoin.tar.gz
        ##Rename folder appropriately
        mv dogecoin-1.10.0 dogecoin-bin
        ##Add dogecoind commands to PATH
        echo 'export PATH=$PATH:~/dogecoin-bin/bin/' > ~/.bashrc
        source ~/.bashrc
        rm dogecoin.tar.gz
    else
        rm dogecoin.tar.gz
        echo "Download failed. Restarting script in 5 seconds"
        sleep 5
        exec /init.sh
    fi
fi

##Check if configuration file exists
if [ ! -f ~/.dogecoin/dogecoin.conf ]; then
    mkdir ~/.dogecoin
    echo rpcuser=dogecoinrpc > ~/.dogecoin/dogecoin.conf
    PWord=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1`
    echo rpcpassword=$PWord >> ~/.dogecoin/dogecoin.conf
fi
##Remove bootstrap.dat.old if it exists
if [ -f ~/.dogecoin/bootstrap.dat.old ]; then
    rm ~/.dogecoin/bootstrap.dat.old
fi

##Start dogecoind daemon
echo Running dogecoin
~/dogecoin-bin/bin/dogecoind -maxconnections=500 -printtoconsole -shrinkdebugfile