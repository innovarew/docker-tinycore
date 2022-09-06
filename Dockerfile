FROM scratch

ADD data/rootfs-x86_64-13.x.tar.xz /

COPY scripts/tc-docker /usr/bin/

RUN NORTC=1 NOZSWAP=1 /etc/init.d/tc-config

USER tc
