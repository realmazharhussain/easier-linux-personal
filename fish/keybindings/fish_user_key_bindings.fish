function fish_user_key_bindings
  # Control key bindings
  bind \e\[1\;5D  backward-bigword         # Ctrl+⬅️
  bind \e\[1\;5C  forward-bigword          # Ctrl+➡️
  bind \b         backward-kill-bigword    # Ctrl+Backspace
  bind \e\[3\;5~  kill-bigword             # Ctrl+Delete
  bind \cR        history-search-backward  # Ctrl+r
  # Alternate key bindings
  bind \e\[1\;3D  backward-word            # Alt+⬅️
  bind \e\[1\;3C  forward-word             # Alt+➡️
  bind \e\x7F     backward-kill-word       # Alt+Backspace
  bind \e\[3\;3~  kill-word                # Alt+Delete
  bind \er        history-search-forward   # Alt+r
end
