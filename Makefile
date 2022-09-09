# Set tinycore release
TC_URL=http://tinycorelinux.net/13.x/x86_64/
TC_VER=$(shell echo "${TC_URL}" | awk -F/ '{print $$4"-"$$5}')

all: rootfs build run

rootfs:
	scripts/tc-docker tce_rootfs_init
build:
	docker build --build-arg TC_VER=${TC_VER} -t tinycore:${TC_VER} -t tinycore:latest .
run:
	docker run -it tinycore:latest /bin/sh
