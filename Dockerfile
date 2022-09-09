FROM scratch
ARG TC_VER=13.x-x86_64

ADD data/rootfs-$TC_VER.tar.xz /

COPY scripts/tc-docker /usr/bin/

RUN NORTC=1 NOZSWAP=1 /etc/init.d/tc-config

USER tc
