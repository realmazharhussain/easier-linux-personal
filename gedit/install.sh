#!/bin/bash

sdir=$(realpath $(dirname $0))
binDir="$root"/usr/local/bin
appsDir="$root"/usr/share/applications
gtk4styleDir="$root"/usr/share/gtksourceview-4/styles
gtk3styleDir="$root"/usr/share/gtksourceview-3.0/styles

if [[ $UID = '0' ]]; then
  echo 'installing gEdit files ...'
  mkdir -p  "$gtk3styleDir" "$gtk4styleDir" "$appsDir" "$binDir"
  cp "$sdir"/color-schemes/*.xml "$gtk3styleDir"/
  cp "$sdir"/color-schemes/*.xml "$gtk4styleDir"/
  chmod +x "$sdir"/bin/*
  cp "$sdir"/bin/* "$binDir"/
  cp "$sdir"/applications/*.desktop "$appsDir"/
else
  sudo --preserve-env=root $0
fi
