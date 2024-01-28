# docker-tcl-core-x86

WORK IN PROGRESS! Forked from [innovarew/docker-tinycore](https://github.com/innovarew/docker-tinycore/tree/main)
[Docker](https://www.docker.com) from scratch image of [Tinycore Linux](http://www.tinycorelinux.net) Core x86 version.

## Quick guide

To build locally, just `make` as show below:

~~~
# prepare the rootfs, build, and run the container
sudo make TC_URL=http://tinycorelinux.net/13.x/x86_64/
~~~

## Detailed steps

What goes on under the hood is shown below:
Note: I want to generate the rootfs-x86-14.x.tar.xz. I don't have it yet.

~~~
cat > Dockerfile <<EOF
FROM scratch
ADD data/rootfs-x86-14.x.tar.xz /
EOF

# unpack tinycore rootfs, sudo needed to unpack cpio proper perms
sudo scripts/tc-docker tce_rootfs_init data/

# build and run the tinycore docker container
sudo docker build -t tinycore:latest .
sudo docker run -it tinycore:latest /bin/sh
~~~

## Overview

`tc-docker` provides the main functionalities for running tinycore on docker:

- First, provides `tc-docker tce_rootfs_init` that extracts the rootfs of a tinycore ISO image.
  This rootfs, can then be used on a `Dockerfile`, using `FROM scratch` and adding the rootfs.

- Second, provides `tc-docker tce_install ext.tcz root/`, that fetches a ext.tcz and unpacks it under `root/`.
  This allows to install `squashfs-tools.tcz`, so the running container can use `unsquashfs` to install tcz extensions into the designated `root/`.

- Last, once tinycore `rootfs`, and, `unsquashfs` are in place inside the container, the `tce-load -wi whois` command can be used on the running container to install new extensions.

One limitation of this approach is that if for any reason the `unsquashfs` stops working, say `squashfs-tools.tcz` or any of its dependences is removed then, `tce-load` stops working, and the ability of installing new tce extensions is lost.

A benefit of using the TinyCore ISO image as source, is that extensions shipped inside the TinyCore ISO under `<iso>/cde` are available, and can be provided as a docker volume to be used for shipping as offline extensions without requiring download.
