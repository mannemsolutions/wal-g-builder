#!/bin/bash
set -ex
GITREV=$(cd wal-g && git rev-parse HEAD)
export GITREV
export BASEIMAGE=${BASEIMAGE:-rockylinux:9}
export WALGVERSION=${WALGVERSION:-v0.0.0-devel}
export WALGURL=${WALGURL:-https://github.com/mannemsolutions/wal-g/}
export DOCKERPLATFORM=${DOCKERPLATFORM:-linux/arm64}
docker-compose up builder
find rpms
