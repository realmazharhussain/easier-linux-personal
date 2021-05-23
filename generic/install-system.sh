#!/bin/bash
if [[ $UID = '0' ]]; then
  sdir="$(realpath "$(dirname "$0")")"

  [ -z "$DESTDIR" ] && DESTDIR=/
  [ -z "$PREFIX" ] && PREFIX=/usr/local

  echo 'installing system-wide files ...'
  mkdir -p "$DESTDIR"/{$PREFIX/share/applications,$PREFIX/bin,etc/xdg/autostart}
  cp "$sdir"/applications/*.desktop "$DESTDIR"/$PREFIX/share/applications/
#  cp "$sdir"/autostart/*.desktop "$DESTDIR"/etc/xdg/autostart/
  chmod +x "$sdir"/bin/*
  cp "$sdir"/bin/* "$DESTDIR"/$PREFIX/bin/
else
  sudo --preserve-env=DESTDIR,PREFIX "$0"
fi
