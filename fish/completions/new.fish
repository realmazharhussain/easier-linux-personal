set -l __templates (ls -1 ~/Templates)
for template in $__templates
  complete -x -c new -a \"(echo $template | string replace -r '\..*$' '')\" -d "Template"
end
