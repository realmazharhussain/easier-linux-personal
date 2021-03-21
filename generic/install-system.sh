#!/bin/bash
if [[ $UID = '0' ]]; then
  sdir="$(realpath "$(dirname "$0")")"
  echo 'installing system-wide files ...'
  mkdir -p "$root"/{usr/share/applications,usr/local/bin,etc/xdg/autostart}
  cp "$sdir"/applications/*.desktop "$root"/usr/share/applications/
#  cp "$sdir"/autostart/*.desktop "$root"/etc/xdg/autostart/
  chmod +x "$sdir"/bin/*
  cp "$sdir"/bin/* "$root"/usr/local/bin/
else
  sudo --preserve-env=root "$0"
fi
