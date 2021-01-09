#!/bin/bash
if [[ $UID = '0' ]]; then
  sdir=$(realpath $(dirname $0))
  echo 'installing wine files ...'
  mkdir -p "$root"/{usr/share/applications,usr/local/bin,etc/xdg/autostart}
  cp "$sdir"/applications/*.desktop "$root"/usr/share/applications/
  cp "$sdir"/autostart/*.desktop "$root"/etc/xdg/autostart/
#  chmod +x "$sdir"/bin/*
#  cp "$sdir"/bin/* "$root"/usr/local/bin/
  for iconsize in $(ls "$sdir"/icons/hicolor/); do
    mkdir -p "$root"/usr/share/icons/hicolor/$iconsize/apps/
    cp "$sdir"/icons/hicolor/$iconsize/apps/* "$root"/usr/share/icons/hicolor/$iconsize/apps/
  done
  if which gtk-update-icon-cache > /dev/null; then
    gtk-update-icon-cache "$root"/usr/share/icons/hicolor &> /dev/null
  else
    update-icon-caches "$root"/usr/share/icons/hicolor &> /dev/null
  fi
else
  sudo --preserve-env=root $0
fi
