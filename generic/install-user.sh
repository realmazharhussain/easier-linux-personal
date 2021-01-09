#!/bin/bash
sdir=$(realpath $(dirname $0))

if [ -z "$home" ]; then
  if [ $UID != 0 ]; then
    echo installing user files for $USER ...
    [ -f $HOME/.bash_aliases ] && [ ! -f $HOME/.bash_aliases.original ] && cp $HOME/.bash_aliases $HOME/.bash_aliases.original
    cp "$sdir"/home/bash_aliases ~/.bash_aliases
  else
    cd "$sdir"/home
    for username in `users`; do
      echo installing user files for $username ...
      sudo su $username -c '
[ -f $HOME/.bash_aliases ] && [ ! -f $HOME/.bash_aliases.original ] && cp $HOME/.bash_aliases $HOME/.bash_aliases.original
cp ./bash_aliases $HOME/.bash_aliases
'
    done
  fi
else
  echo installing user files ...
  mkdir -p "$home"
  [ -f "$home"/.bash_aliases ] && [ ! -f "$home"/.bash_aliases.original ] && cp "$home"/.bash_aliases "$home"/.bash_aliases.original
  cp "$sdir"/home/bash_aliases "$home"/.bash_aliases
fi
