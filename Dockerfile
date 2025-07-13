#
# @description Dockerfile, for building innovarew/docker-tinycore
# @author innovarew <innovarew at github.com> (c) Copyright 2022
# @url github.com/innovarew/docker-tinycore
#

FROM scratch
MAINTAINER "innovarew <innovarew at github.com> (c) Copyright 2022"
LABEL author="@author innovarew <innovarew at github.com> (c) Copyright 2022."
ARG TC_VER=16.x-x86_64

ADD data/rootfs-$TC_VER.tar.xz /

COPY scripts/tc-docker /usr/bin/

RUN NORTC=1 NOZSWAP=1 /etc/init.d/tc-config

USER tc
CMD ["/bin/sh"]
