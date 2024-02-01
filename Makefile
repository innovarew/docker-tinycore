# Set tinycore release
export TC_ARCH=x86_64
export TC_URL=http://tinycorelinux.net/14.x/${TC_ARCH}/

all: rootfs build run

rootfs:
	scripts/tc-docker tce_rootfs_init
build:
	docker build --build-arg TC_VER=${TC_VER} -t tinycore:${TC_VER} -t tinycore:latest .
run:
	docker run -it tinycore:latest /bin/sh
