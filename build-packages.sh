#!/bin/bash

dpkg_deb=$(which dpkg-deb)
pkg_name="docker-ssh"

if [[ -x $dpkg_deb ]]; then
    echo "building debian package"

    version=$(grep Version pkg/deb/DEBIAN/control | cut -d ' ' -f 2)
    arch=$(grep Architecture pkg/deb/DEBIAN/control | cut -d ' ' -f 2)
    pkg=$(grep Package pkg/deb/DEBIAN/control | cut -d ' ' -f 2)
    name="${pkg}-${version}_${arch}"

    echo "building $name"

    mkdir -p dist/debian
    mkdir -p pkg/deb/usr/bin
    cp docker-ssh pkg/deb/usr/bin
    dpkg-deb --build pkg/deb "dist/debian/$name.deb"
    rm pkg/deb/usr/bin/docker-ssh
fi