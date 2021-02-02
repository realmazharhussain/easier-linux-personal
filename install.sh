#!/bin/bash

if [ $UID != 0 ]; then
  sudo --preserve-env=root,home $0
  exit $?
fi

if [ ! -z "$root" ]; then
  [ ! -d "$root" ] && mkdir -p "$root" && echo created dirctory "$root"
  root=$(realpath "$root")
  echo target root dirctory = "$root"
else
  echo target root dirctory = /
fi

if [ ! -z "$home" ]; then
  [ ! -d "$home" ] && mkdir -p "$home" && echo created dirctory "$home"
  home=$(realpath "$home")
  echo target home dirctory = "$home"
fi

echo

if [ ! -z $SUDO_USER ]; then
  su $SUDO_USER -c ./generic/install-user.sh
else
  ./generic/install-user.sh
fi

./generic/install-system.sh
which gedit &> /dev/null && ./gedit/install.sh
which apt &> /dev/null && ./debian/install.sh
which c++ &> /dev/null && ./c++/install.sh
which ffmpeg &> /dev/null && ./ffmpeg/install.sh
which wine &> /dev/null && ./wine/install.sh

echo -e "\ndone."
