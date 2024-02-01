FROM scratch
ARG TC_VER=14.x-x86

ADD data/rootfs-$TC_VER.tar.xz /

COPY scripts/tc-docker /usr/bin/

RUN NORTC=1 NOZSWAP=1 /etc/init.d/tc-config

USER tc
CMD ["/bin/sh"]
