ARG BASEIMAGE=rockylinux:10
FROM ${BASEIMAGE} AS build-stage
ARG GITREV
ARG WALGVERSION
RUN echo -e 'fastestmirror=true\nmax_parallel_downloads=20\ninstallonly_limit=10\ndeltarpm=true' >> /etc/dnf/dnf.conf && \
    grep -qi ID=fedora /etc/os-release || dnf install -y epel-release && \
    dnf install -y golang git cmake rpm-build lzo-devel libsodium-devel

WORKDIR /go/src/app
COPY wal-g .
RUN USE_BROTLI=yes USE_LIBSODIUM=yes USE_LZO=yes make deps && \
    go build -v -tags "brotli libsodium liblzo" -ldflags "-s -w -X github.com/wal-g/wal-g/cmd/pg.buildDate=`date -u +%Y.%m.%d_%H:%M:%S` -X github.com/wal-g/wal-g/cmd/pg.gitRevision=$GITREV -X github.com/wal-g/wal-g/cmd/pg.walgVersion=$WALGVERSION" -o /usr/local/bin/wal-g-pg ./main/pg

FROM ${BASEIMAGE}
COPY --from=build-stage /usr/local/bin/wal-g-pg /usr/local/bin/
RUN grep -qi ID=fedora /etc/os-release || dnf install -y epel-release && \
    dnf install -y libsodium lzo brotli rpm-build
CMD /usr/local/bin/wal-g-pg
