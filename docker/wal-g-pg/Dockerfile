FROM rockylinux:9 AS build-stage
ARG GITREV
ARG VERSION
RUN dnf install -y epel-release && \
    dnf install -y golang git cmake rpm-build lzo-devel libsodium-devel

WORKDIR /go/src/app
COPY wal-g .
RUN USE_BROTLI=yes USE_LIBSODIUM=yes USE_LZO=yes make deps && \
    go build -v -tags "brotli libsodium liblzo" -ldflags "-s -w -X github.com/wal-g/wal-g/cmd/pg.buildDate=`date -u +%Y.%m.%d_%H:%M:%S` -X github.com/wal-g/wal-g/cmd/pg.gitRevision=$GITREV -X github.com/wal-g/wal-g/cmd/pg.walgVersion=$WALGVERSION" -o /usr/local/bin/wal-g-pg ./main/pg

FROM rockylinux:9
COPY --from=build-stage /usr/local/bin/wal-g-pg /usr/local/bin/
RUN dnf install -y epel-release && \
    dnf install -y libsodium lzo brotli
CMD /usr/local/bin/wal-g-pg
