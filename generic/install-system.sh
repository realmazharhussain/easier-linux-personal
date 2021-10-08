#!/bin/bash
if [[ $UID = '0' ]]; then
  sdir="$(realpath "$(dirname "$0")")"

  [ -z "$DESTDIR" ] && DESTDIR=/
  [ -z "$PREFIX" ] && PREFIX=/usr/local

  echo 'installing system-wide files ...'
  mkdir -p "$DESTDIR/$PREFIX"/{bin,share/{applications,fish/vendor_completions.d}}
  install -m644 "$sdir"/applications/*.desktop "$DESTDIR"/$PREFIX/share/applications/
#  install -Dm644 "$sdir"/autostart/*.desktop "$DESTDIR"/etc/xdg/autostart/
  install -m755 "$sdir"/bin/* "$DESTDIR"/$PREFIX/bin/
  install -m755 "$sdir"/completions/* "$DESTDIR/$PREFIX"/share/fish/vendor_completions.d/
else
  sudo --preserve-env=DESTDIR,PREFIX "$0"
fi
