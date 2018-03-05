#!/bin/bash

## Update packages
apt update && apt upgrade -y && apt install -y curl gpg ca-certificates tar dirmngr
## Check if binaries are already installed
cd ~
if [ ! -f ~/litecoin-bin/bin/litecoind ]; then
    curl -o litecoin.tar.gz https://download.litecoin.org/litecoin-0.15.1/linux/litecoin-0.15.1-x86_64-linux-gnu.tar.gz
    curl -o key.asc https://download.litecoin.org/litecoin-0.15.1/linux/litecoin-0.15.1-x86_64-linux-gnu.tar.gz.asc
    gpg --recv-keys FE3348877809386C
    gpg --verify key.asc litecoin.tar.gz
    if [ $? -eq 0 ]; then
        tar -xvf litecoin.tar.gz
        ##Rename folder appropriately
        mv litecoin-0.15.1 litecoin-bin
        ##Add litecoind commands to PATH
        echo 'export PATH=$PATH:~/litecoin-bin/bin/' > ~/.bashrc
        source ~/.bashrc
        rm litecoin.tar.gz key.asc
    else
        rm litecoin.tar.gz key.asc
        echo "Verification failed. Restarting script in 5 seconds"
        sleep 5
        exec /init.sh
    fi
fi

##Check if configuration file exists
if [ ! -f ~/.litecoin/litecoin.conf ]; then
    mkdir ~/.litecoin
    echo rpcuser=litecoinrpc > ~/.litecoin/litecoin.conf
    PWord=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1`
    echo rpcpassword=$PWord >> ~/.litecoin/litecoin.conf
fi
##Remove bootstrap.dat.old if it exists
if [ -f ~/.litecoin/bootstrap.dat.old ]; then
    rm ~/.litecoin/bootstrap.dat.old
fi

##Start litecoind daemon
echo Running litecoin
~/litecoin-bin/bin/litecoind -maxconnections=500 -printtoconsole -shrinkdebugfile