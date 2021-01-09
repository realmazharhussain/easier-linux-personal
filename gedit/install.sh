#!/bin/bash
sdir=$(realpath $(dirname $0))
if [[ $UID = '0' ]]; then
  echo 'installing gEdit files ...'
  mkdir -p "$root"/usr/share/gtksourceview-4/styles/ "$root"/usr/share/gtksourceview-3.0/styles/
  cp "$sdir"/color-schemes/*.xml "$root"/usr/share/gtksourceview-4/styles/
  cp "$sdir"/color-schemes/*.xml "$root"/usr/share/gtksourceview-3.0/styles/
else
  sudo --preserve-env=root $0
fi
