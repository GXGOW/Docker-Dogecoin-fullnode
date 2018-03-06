# Dogecoin node for Docker

![wow](http://dogecoin.com/imgs/dogecoin-300.png)

Run a Dogecoin fullnode in an isolated Docker container

**But why should I do that?!**

* To support the Dogecoin community.
* Just for the sake of doing it.
* Because it's fun.

## How to install

**Make sure that port 22556 is being forwarded on your router!**

It's not that hard, actually. There are two ways to get it up and running:

### A. Pull and run the image from the [Docker Store](https://store.docker.com/community/images/gxgow/dogenode)

You only need to run one command to get it up and running:

```bash

docker run -d -p 22556:22556 --name dogenode gxgow/dogenode

```

Just wait until the process completes and boom, your Dogecoin node is up and running!

### B. Build from source

This requires a few extra steps, but it will get you the same result. It can be helpful if you want to customize the init script, for example.

```bash
# Clone the git repository
git clone https://github.com/GXGOW/Docker-Dogecoin-fullnode.git

# Perform your customisations (optional)

# Run the build script (it'll also run as a .sh script. Just copy the contents or change the file extension.)
./build.sh
```

Same result, it's up and running.

## Optional: kickstart the node with a bootstrap file

Initial sync may take a looooong time (total blockchain size as of writing is over 20 GB!). That's why it may be useful to have a bootstrap file to make the initial sync process a little faster.

You can get the bootstrap.dat file from:

* [Torrent link](http://jrn.me.uk/dogecoin_torrents/bootstrap_2018-01-09.dat.torrent) (Snapshot 2018-01-09, credit goes to [this reddit thread](https://www.reddit.com/r/dogecoin/comments/7p6f2m/dogecoin_bootstrapdat_torrent/))

Sit back and relax while it's downloading. It's a large file, so it may take some time.

Before copying the bootstrap file to the Docker container, **make sure you've run the container at least once**. Then, copy bootstrap.dat using following commands:

```bash
# Stop the container
docker stop dogenode

# Copy bootstrap.dat to the container
docker cp /path/to/bootstrap.dat dogenode:/root/.dogecoin/

# Start the container again
docker start dogenode
```

Once the node has imported the bootstrap.dat file, it'll be renamed to bootstrap.dat.old. This file will automatically be removed on the next boot.

**TO THE MOON!!!**