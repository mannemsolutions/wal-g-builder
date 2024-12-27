%global _prefix /usr/local
Summary: Archival and Restoration for PostgreSQL databases
Name: wal-g-pg
Version: %{_version}
Release: 1%{?dist}
License: Apache-2.0
Group: Unspecified
Url: %{_url}
BuildArch: %{_arch}
Requires: glibc < 2.29
Requires: libsodium
Requires: lzo
Requires: brotli

%description
Archival and Restoration for databases in the Cloud

%prep

%install
mkdir -p %{buildroot}/%{_bindir}
%{__install} -m 0755 %{_bindir}/wal-g-pg %{buildroot}/%{_bindir}/wal-g-pg

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/wal-g-pg
