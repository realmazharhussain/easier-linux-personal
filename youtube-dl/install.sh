#!/bin/bash
sdir="$(realpath "$(dirname "$0")")"
if [[ $UID = '0' ]]; then
  echo 'installing youtube-dl files ...'
  
  [ -z "$DESTDIR" ] && DESTDIR=/
  [ -z "$PREFIX" ] && PREFIX=/usr/local

  mkdir -p "$DESTDIR"/$PREFIX/bin/ #"$DESTDIR"/$PREFIX/share/applications/
  chmod a+x "$sdir"/bin/*
  cp "$sdir"/bin/* "$DESTDIR"/$PREFIX/bin/
#  cp "$sdir"/applications/*.desktop "$DESTDIR"/$PREFIX/share/applications/
else
  sudo --preserve-env=DESTDIR,PREFIX "$0"
fi
