#!/usr/bin/env fish

echo "reconfiguring prompt"

tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='12-hour format' --rainbow_prompt_separators=Slanted --powerline_prompt_heads=Slanted --powerline_prompt_tails=Slanted --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Dotted --powerline_right_prompt_frame=Yes --prompt_connection_andor_frame_color=Dark --prompt_spacing=Sparse --icons='Many icons' --transient=Yes

echo "run `exec fish` now" | mdcat
