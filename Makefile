# Set tinycore release
TC_URL=http://tinycorelinux.net/13.x/x86_64/

all: rootfs build run

rootfs:
	scripts/tc-docker tce_rootfs_init
build:
	docker build -t tinycore:latest .
run:
	docker run -it tinycore:latest /bin/sh
