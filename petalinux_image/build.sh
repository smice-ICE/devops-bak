#! /bin/bash
ubuntu_version=$1
petalinux_version=$2
cd ${petalinux_version}
docker build --target petalinux-requirement -t ubuntu-petalinux-requirement:$ubuntu_version ./
docker build --target petalinux-build -t petalinux:v${petalinux_version} ./