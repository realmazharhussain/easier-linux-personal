set -l __templates (ls -1 ~/Templates | string replace -r '\..*$' '')
set -l templates
for template in $__templates
  set -a templates \'$template\'
end
complete -x -c new -n "not __fish_seen_subcommand_from $templates" -a "$templates" -d "Template"
