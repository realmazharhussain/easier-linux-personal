function fish_right_prompt
  if ! [ $__last_command_exit_status = 0 ]
    echo (set_color red)$__last_command_exit_status
  end
  set -e __last_command_exit_status
end
