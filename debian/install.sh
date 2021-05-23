#!/bin/bash
sdir="$(realpath "$(dirname "$0")")"
if [[ $UID = '0' ]]; then

  [ -z "$DESTDIR" ] && DESTDIR=/
  [ -z "$PREFIX" ] && PREFIX=/usr/local

  echo 'installing debian/ubuntu files ...'
  mkdir -p "$DESTDIR"/$PREFIX/bin/ "$DESTDIR"/$PREFIX/share/applications/
  chmod a+x "$sdir"/bin/*
  cp "$sdir"/bin/* "$DESTDIR"/$PREFIX/bin/
  cp "$sdir"/applications/*.desktop "$DESTDIR"/$PREFIX/share/applications/
else
  sudo --preserve-env=DESTDIR,PREFIX "$0"
fi
