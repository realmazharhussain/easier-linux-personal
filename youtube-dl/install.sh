#!/bin/bash
sdir="$(realpath "$(dirname "$0")")"
if [[ $UID = '0' ]]; then
  echo 'installing youtube-dl files ...'
  mkdir -p "$root"/usr/local/bin/ #"$root"/usr/share/applications/
  chmod a+x "$sdir"/bin/*
  cp "$sdir"/bin/* "$root"/usr/local/bin/
#  cp "$sdir"/applications/*.desktop "$root"/usr/share/applications/
else
  sudo --preserve-env=root "$0"
fi
