#!/bin/bash

var="Hello World"

cd /workdir/yocto
# source poky/oe-init-build-env /board/$1/
source poky/oe-init-build-env /workdir/yocto/board/bbb/

 
# print it 
echo "$var"

echo "BUILD=$1"
echo "RECIPE$2"

