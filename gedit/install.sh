#!/bin/bash

sdir="$(realpath "$(dirname "$0")")"

[ -z "$DESTDIR" ] && DESTDIR=/
[ -z "$PREFIX" ] && PREFIX=/usr/local

binDir="$DESTDIR"/$PREFIX/bin
appsDir="$DESTDIR"/$PREFIX/share/applications
gtk4styleDir="$DESTDIR"/$PREFIX/share/gtksourceview-4/styles
gtk3styleDir="$DESTDIR"/$PREFIX/share/gtksourceview-3.0/styles

if [[ $UID = '0' ]]; then
  echo 'installing gEdit files ...'
  mkdir -p  "$gtk3styleDir" "$gtk4styleDir" "$appsDir" "$binDir"
  cp "$sdir"/color-schemes/*.xml "$gtk3styleDir"/
  cp "$sdir"/color-schemes/*.xml "$gtk4styleDir"/
  chmod +x "$sdir"/bin/*
  cp "$sdir"/bin/* "$binDir"/
  cp "$sdir"/applications/*.desktop "$appsDir"/
else
  sudo --preserve-env=DESTDIR,PREFIX "$0"
fi
