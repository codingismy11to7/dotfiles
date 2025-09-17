function repeat_key_toggle
  set VAR __repeat_key_is_running

  if test $$VAR -gt 0
    set -U $VAR 0
  else
    set -U $VAR 1

    while test $$VAR -gt 0
      sleep 0.25

      # check again after the sleep
      if test $$VAR -gt 0
        # 13 is ] in dvorak, i think, 27 is = i think
	# 17 is , in dvorak
        ydotool key 17:1 17:0
      end
    end
  end

end
