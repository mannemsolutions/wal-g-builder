#!/bin/bash
set -ex
WALGVERSION=${WALGVERSION:-$(wal-g-pg -v | awk '{print $3}' | grep -oE 'v?[a-zA-Z0-9.]*')}
WALGVERSION=${WALGVERSION:-v0.0.0}
RPMVERSION=${RPMVERSION:-${WALGVERSION%-*}}
WALGURL=${WALGURL:-https://github.com/mannemsolutions/wal-g/branches}
echo "
%_version $RPMVERSION
%_url $WALGURL
" >~/.rpmmacros
rpmbuild -ba ./specs/wal-g-pg.spec
mkdir -p ./rpms/
cp ~/rpmbuild/RPMS/*/*.rpm ./rpms/
