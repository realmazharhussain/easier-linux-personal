#!/bin/bash

if [ $UID != '0' ]; then
  sudo --preserve-env=root,home $0
  exit $?
fi

if [ ! -z "$root" ]; then
  if [ ! -d "$root" ]; then
    echo directory \"$root\" not found. >&2
    echo uninstall cancelled. >&2
    echo quitting... >&2
    exit 1
  fi
  root=$(realpath "$root")
  echo target root dirctory = "$root"
else
  echo target root dirctory = /
fi

appdir="$root/usr/share/applications"
bindir="$root/usr/local/bin"
autostartdir="$root/etc/xdg/autostart"

echo uninstalling easier-linux ...
{
  rm "$autostartdir"/wineboot.desktop
  rm "$appdir"/{{C,c}onvert-to{-audio,m4a,video},extract-{video,m4a{-audio,}},run-in-terminal,run-as-root,install-with-apt}.desktop
  rm "$bindir"/{{C,c}onvert-to{-audio,m4a,video},extract-{video,m4a{-audio,}},run-in-terminal,run-as-root,install-with-apt,srch{i,},show-splash{-screen,},aspect,change-video-aspect-ratio,comprun}
  rm "$root"/usr/share/gtksourceview-{3.0,4}/styles/classicMod.xml
} &> /dev/null
echo done.