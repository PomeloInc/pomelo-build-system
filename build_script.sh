#!/bin/bash

set -e

usage="$(basename "$0") [-h] [-b BOARD] [-r RECIPE] [-c YOCTO_CMD]
Build a yocto project
where:
    -h  show this help text
    -b  the board you want to build
    -r  the recipe you want to build
    -c  a yocto-project based command you want to execute instead (e.g. devtool)"

# constants
YOCTO=/workdir/yocto
BOARD="bbb"
RECIPE="core-image-minimal"

options=':hi:b:r:c:'
while getopts $options option; do
  case "$option" in
    h) echo "$usage"; exit;;
    b) BOARD=$OPTARG;;
    r) RECIPE=$OPTARG;;
    c) YOCTO_CMD=$OPTARG;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2; echo "$usage" >&2; exit 1;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2; echo "$usage" >&2; exit 1;;
  esac
done

# source poky/oe-init-build-env
if [ "$BOARD" ] && [ "$RECIPE" ]; then
    source $YOCTO/poky/oe-init-build-env $YOCTO/board/$BOARD/
    echo "$RECIPE"
    bitbake $RECIPE
else
    echo "bad input"
fi

# mandatory arguments
if [ ! "$BOARD" ] && [ ! "$RECIPE" ] || [ ! "$YOCTO_CMD" ]; then
  echo "$usage" >&2; exit 1
  echo "arguments -b and -r or -c must be provided"
fi

# DEBUG
echo "Hello World"
echo "BOARD=$1"
echo "RECIPE$2"
echo "BOARD=$BOARD"
echo "RECIPE=$RECIPE"

