#
# @description Makefile, for building innovarew/docker-tinycore
# @author innovarew <innovarew at github.com> (c) Copyright 2022
# @url github.com/innovarew/docker-tinycore
# SPDX-License-Identifier: GPL-2.0-or-later
#

# Set tinycore release
TC_URL=http://tinycorelinux.net/15.x/x86_64/
TC_VER=$(shell echo "${TC_URL}" | awk -F/ '{print $$4"-"$$5}')

all: rootfs build run

rootfs:
	scripts/tc-docker tce_rootfs_init
build:
	docker build --build-arg TC_VER=${TC_VER} -t tinycore:${TC_VER} -t docker-tinycore-local:latest .
run:
	docker run -it docker-tinycore-local:latest /bin/sh
