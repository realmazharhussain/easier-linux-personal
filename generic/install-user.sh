#!/bin/bash

sdir="$(realpath "$(dirname "$0")")"

if [ -z "$home" ]; then
  if [ $UID != 0 ]; then
    echo installing user files for $USER ...
    if [ -f "$HOME"/.bash_aliases ]; then
      cp "$sdir"/home/bash_aliases ~/.bash_aliases.easier-linux
    else
      cp "$sdir"/home/bash_aliases ~/.bash_aliases
    fi
  else
    cd "$sdir"/home
    for username in `users`; do
      echo installing user files for $username ...
      sudo su $username -c '
if [ -f $HOME/.bash_aliases ]; then cp ./bash_aliases $HOME/.bash_aliases.easier-linux; else cp ./bash_aliases $HOME/.bash_aliases; fi
'
    done
  fi
else
  echo installing user files ...
  mkdir -p "$home"
  if [ -f "$home"/.bash_aliases ]; then
    cp "$sdir"/home/bash_aliases "$home"/.bash_aliases.easier-linux
  else
    cp "$sdir"/home/bash_aliases "$home"/.bash_aliases
  fi
fi
