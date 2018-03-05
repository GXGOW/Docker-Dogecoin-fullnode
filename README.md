# Litecoin node for Docker

![litecoin](https://litecoin.org/img/litecoin.svg)

*This is pretty much the same as my [Dogecoin node](https://github.com/GXGOW/Docker-Dogecoin-fullnode). Only difference is that every 'doge' is replaced by 'lite'.*

Run a Litecoin fullnode in an isolated Docker container

**But why should I do that?!**

* To support the Litecoin community.
* Just for the sake of doing it.
* Because it's fun.

## How to install

**Make sure that port 9333 is being forwarded on your router!**

It's not that hard, actually. There are two ways to get it up and running:

### A. Pull and run the image from the [Docker Store](https://store.docker.com/community/images/gxgow/litenode)

You only need to run one command to get it up and running:

```bash

docker run -d -p 9333:9333 --name litenode gxgow/litenode

```

Just wait until the process completes and boom, your Litecoin node is up and running!

### B. Build from source

This requires a few extra steps, but it will get you the same result. It can be helpful if you want to customize the init script, for example.

```bash
# Clone the git repository
git clone https://github.com/GXGOW/Docker-Litecoin-fullnode.git

# Perform your customisations (optional)

# Run the build script (it'll also run as a .sh script. Just copy the contents or change the file extension.)
./build.sh
```

Same result, it's up and running.

## Optional: kickstart the node with a bootstrap file

Initial sync may take some time (total blockchain size as of writing is about 8 GB). That's why it may be useful to have a bootstrap file to make the initial sync process a little faster.

You can get the bootstrap.dat file from [bootstrap.litecoinnode.org](http://bootstrap.litecoinnode.org/) (They regularly upload an up-to-date bootstrap file)

Sit back and relax while it's downloading. It's a large file, so it may take some time.

Before copying the bootstrap file to the Docker container, **make sure you've run the container at least once**. Then, copy bootstrap.dat using following commands:

```bash
# Stop the container
docker stop litenode

# Copy bootstrap.dat to the container
docker cp /path/to/bootstrap.dat litenode:/root/.litecoin/

# Start the container again
docker start litenode
```

Once the node has imported the bootstrap.dat file, it'll be renamed to bootstrap.dat.old. This file will automatically be removed on the next boot.