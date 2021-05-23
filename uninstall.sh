#!/bin/bash

if [ $UID != '0' ]; then
  sudo --preserve-env=DESTDIR,PREFIX,home "$0"
  exit $?
fi

[ -z "$DESTDIR" ] && DESTDIR=/
[ -z "$PREFIX" ] && PREFIX=/usr/local

if [ ! -z "$DESTDIR" ]; then
  if [ ! -d "$DESTDIR" ]; then
    echo directory \"$DESTDIR\" not found. >&2
    echo uninstall cancelled. >&2
    echo quitting... >&2
    exit 1
  fi
  DESTDIR=$(realpath "$DESTDIR")
  echo target root dirctory = "$DESTDIR"
else
  echo target root dirctory = /
fi

appdir="$(realpath -m "$DESTDIR/$PREFIX/share/applications")"
bindir="$(realpath -m "$DESTDIR/$PREFIX/bin")"
autostartdir="$(realpath -m "$DESTDIR/etc/xdg/autostart")"

echo uninstalling easier-linux ...
{
  rm "$autostartdir"/wine{,boot}.desktop
  rm "$appdir"/{{C,c}onvert-to{-audio,m4a,video},extract-{video,m4a{-audio,}},run-in-terminal,run-as-root,install-with-apt}.desktop
  rm "$bindir"/{{C,c}onvert-to{-audio,m4a,video},extract-{video,m4a{-audio,}},run-in-terminal,run-as-root,install-with-apt,srch{i,},show-splash{-screen,},aspect,change-video-aspect-ratio,comprun,ytdl}
  rm "$(realpath -m "$DESTDIR"/$PREFIX)"/share/gtksourceview-{3.0,4}/styles/classicMod.xml
} &> /dev/null
echo done.
