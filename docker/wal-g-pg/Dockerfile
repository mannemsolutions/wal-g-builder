FROM rockylinux:9 AS build-stage
ARG GITREV=0809a90e988d29db2841cfccee2dc255163725a7
ARG WALG_VERSION=v3.0.4
ENV WALG_VERSION=${WALG_VERSION}
RUN dnf install -y epel-release && \
    dnf install -y golang git cmake rpm-build lzo-devel libsodium-devel

WORKDIR /go/src/app
COPY wal-g .
RUN go build -v -mod vendor -tags "brotli libsodium lzo" -ldflags "-s -w -X github.com/wal-g/wal-g/cmd/pg.buildDate=`date -u +%Y.%m.%d_%H:%M:%S` -X github.com/wal-g/wal-g/cmd/pg.gitRevision=$GITREV -X github.com/wal-g/wal-g/cmd/pg.walgVersion=$WALG_VERSION" -o wal-g ./main/pg

FROM rockylinux:9
COPY --from=build-stage /go/src/app/wal-g /usr/local/bin/wal-g-pg
RUN dnf install -y epel-release && \
    dnf install -y libsodium lzo brotli
CMD /usr/local/bin/wal-g-pg
