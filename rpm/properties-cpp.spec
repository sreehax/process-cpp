Name: properties-cpp
Summary: properties-cpp
Version: 1.1
Release: 1
Group: System/Applications
License: LGPL
URL: https://github.com/sreehax
Source: %{name}-%{version}.tar.gz

BuildRequires: cmake
BuildRequires: gtest-devel
BuildRequires: libgmock-devel

%prep
%setup -q -n %{name}-%{version}

%build
mkdir -p build
cd build
%cmake -DUSE_HEADLESS=ON -DBUILD_TESTING=OFF -DCMAKE_BUILD_TYPE=Debug ..
make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
pushd build
%make_install
popd

%files
%defattr(-,root,root,-)
