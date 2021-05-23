#!/bin/bash
if [[ $UID = '0' ]]; then
  sdir="$(realpath "$(dirname "$0")")"

  [ -z "$DESTDIR" ] && DESTDIR=/
  [ -z "$PREFIX" ] && PREFIX=/usr/local

  echo 'installing wine files ...'
  mkdir -p "$DESTDIR"/{$PREFIX/share/applications,$PREFIX/bin,etc/xdg/autostart}
  cp "$sdir"/applications/*.desktop "$DESTDIR"/$PREFIX/share/applications/
  cp "$sdir"/autostart/*.desktop "$DESTDIR"/etc/xdg/autostart/
#  chmod +x "$sdir"/bin/*
#  cp "$sdir"/bin/* "$DESTDIR"/$PREFIX/bin/
  for iconsize in $(ls "$sdir"/icons/hicolor/); do
    mkdir -p "$DESTDIR"/$PREFIX/share/icons/hicolor/$iconsize/apps/
    cp "$sdir"/icons/hicolor/$iconsize/apps/* "$DESTDIR"/$PREFIX/share/icons/hicolor/$iconsize/apps/
  done
  if which gtk-update-icon-cache > /dev/null; then
    gtk-update-icon-cache "$DESTDIR"/$PREFIX/share/icons/hicolor &> /dev/null
  else
    update-icon-caches "$DESTDIR"/$PREFIX/share/icons/hicolor &> /dev/null
  fi
else
  sudo --preserve-env=DESTDIR,PREFIX "$0"
fi
