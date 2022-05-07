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
YOCTO_DIR=/workdir/yocto
BOARD=""
RECIPE=""
YOCTO_CMD=""

options=':hi:b:r:c:'
while getopts $options option; do
  case "$option" in
    h) echo "$usage"; exit;;
    b) BOARD=$OPTARG;;
    r) RECIPE=$OPTARG;;
    c) YOCTO_CMD=$OPTARG;;
    :) echo "missing argument for -%s\n" "$OPTARG" >&2; echo "$usage" >&2; exit 1;;
   \?) echo "illegal option: -%s\n" "$OPTARG" >&2; echo "$usage" >&2; exit 1;;
  esac
done

# mandatory arguments
if [ ! "$BOARD" ]; then
  echo "argument -b must be provided"
fi
if [ ! "$YOCTO_CMD" ] && [ ! "$RECIPE" ] ; then
  echo "argument -r or -c must be provided"
  echo "$usage" >&2; exit 1
fi

# source poky/oe-init-build-env and do something yocto
if [ "$RECIPE" ]; then
    source $YOCTO_DIR/poky/oe-init-build-env $YOCTO_DIR/board/$BOARD/
    bitbake $RECIPE
elif [ "$YOCTO_CMD" ] ; then
    source $YOCTO_DIR/poky/oe-init-build-env $YOCTO_DIR/board/$BOARD/
    $YOCTO_CMD
else
    echo "$usage" >&2; exit 1
fi

# DEBUG
# printf "\n\n\nDEBUG:\n"
# echo "BOARD=$1"
# echo "RECIPE$2"
# echo "BOARD=$BOARD"
# echo "RECIPE=$RECIPE"
# echo "YOCTO_CMD=$YOCTO_CMD"

