#!/bin/bash
echo "%_version $(wal-g-pg -v | awk '{print $3}')" >~/.rpmmacros
rpmbuild -ba ./specs/wal-g-pg.spec
mkdir -p ./rpms/
cp ~/rpmbuild/RPMS/*/*.rpm ./rpms/
