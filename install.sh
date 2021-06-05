#!/bin/bash

if [ $UID != 0 ]; then
  sudo --preserve-env=DESTDIR,PREFIX,home "$0" "$@"
  exit $?
fi

[ -z "$DESTDIR" ] && DESTDIR=/
[ -z "$PREFIX" ] && PREFIX=/usr/local

if [ ! -z "$DESTDIR" ]; then
  [ ! -d "$DESTDIR" ] && mkdir -p "$DESTDIR" && echo created dirctory "$DESTDIR"
  DESTDIR=$(realpath "$DESTDIR")
  echo target DESTDIR dirctory = "$DESTDIR"
else
  echo target DESTDIR dirctory = /
fi

if [ ! -z "$home" ]; then
  [ ! -d "$home" ] && mkdir -p "$home" && chmod 777 "$home" && echo created dirctory "$home"
  home="$(realpath "$home")"
  echo target home dirctory = "$home"
fi

echo

if [ "$1" != '--system-only' ]; then
  if [ -n "$SUDO_USER" ]; then
    su $SUDO_USER -c ./generic/install-user.sh
  else
  ./generic/install-user.sh
  fi
fi

./generic/install-system.sh
which gedit &> /dev/null && ./gedit/install.sh
which apt &> /dev/null && ./debian/install.sh
which c++ &> /dev/null && ./c++/install.sh
which ffmpeg &> /dev/null && ./ffmpeg/install.sh
which wine &> /dev/null && ./wine/install.sh
which youtube-dl &> /dev/null && ./youtube-dl/install.sh

echo -e "\ndone."
