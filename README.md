![Docker build](https://github.com/innovarew/docker-tinycore/actions/workflows/docker-image.yml/badge.svg?event=push)
![Docker publish](https://github.com/innovarew/docker-tinycore/actions/workflows/docker-publish.yml/badge.svg?event=push)
![GitHub file size in bytes](https://img.shields.io/github/size/innovarew/docker-tinycore/data/rootfs-14.x-x86_64.tar.xz?label=image%20size:latest)
![GitHub license](https://img.shields.io/github/license/innovarew/docker-tinycore)

# docker-tinycore

[Docker](https://www.docker.com) from scratch image of [Tinycore Linux](http://www.tinycorelinux.net)

## Quick guide

To build on top of it, just pull from the [docker-tinycore package](https://github.com/innovarew/docker-tinycore/pkgs/container/docker-tinycore/versions)

~~~
echo FROM ghcr.io/innovarew/docker-tinycore > Dockerfile
docker build -t docker-tinycore-scratch .
~~~

To run, just `docker run` as show below:

~~~
sudo docker run -it ghcr.io/innovarew/docker-tinycore
~~~

To build locally, just `make` as show below:

~~~
# prepare the rootfs, build, and run the container
sudo make TC_URL=http://tinycorelinux.net/13.x/x86_64/
~~~

## Supported versions

Ready to use docker images from [docker-tinycore](https://github.com/innovarew/docker-tinycore/pkgs/container/docker-tinycore/versions):

| Release/Arch   | Docker Image                                         |
| -------------- | ---------------------------------------------------- |
| [latest](https://github.com/innovarew/docker-tinycore/)     | `FROM ghcr.io/innovarew/docker-tinycore:latest`      |
| [14.x-x86_64](https://github.com/innovarew/docker-tinycore/tree/14.x-x86_64)| `FROM ghcr.io/innovarew/docker-tinycore:14.x-x86_64` |
| [13.x-x86_64](https://github.com/innovarew/docker-tinycore/tree/13.x-x86_64)| `FROM ghcr.io/innovarew/docker-tinycore:13.x-x86_64` |
| [12.x-x86_64](https://github.com/innovarew/docker-tinycore/tree/12.x-x86_64)| `FROM ghcr.io/innovarew/docker-tinycore:12.x-x86_64` |
| [11.x-x86_64](https://github.com/innovarew/docker-tinycore/tree/11.x-x86_64)| `FROM ghcr.io/innovarew/docker-tinycore:11.x-x86_64` |
| [10.x-x86_64](https://github.com/innovarew/docker-tinycore/tree/10.x-x86_64)| `FROM ghcr.io/innovarew/docker-tinycore:10.x-x86_64` |

## Detailed steps

What goes on under the hood is shown below:

~~~
cat > Dockerfile <<EOF
FROM scratch
ADD data/rootfs-x86_64-13.x.tar.xz /
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
