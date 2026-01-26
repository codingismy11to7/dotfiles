{
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.dotfiles;
  inherit (cfg) headless;
in
if headless then
  { }
else
  let
    repeat_key_toggle = pkgs.writeShellScriptBin "repeat_key_toggle" ''
      # toggle script that hits comma every quarter second until run again
      NOTIFY_ID_FILE="/tmp/repeat_key_notify_id"

      # 1. If we are the internal loop instance, run the loop immediately.
      # This MUST be first so we don't accidentally pkill ourselves.
      if [ "$1" = "--internal-loop" ]; then
          while true; do
              ${pkgs.unstable.ydotool}/bin/ydotool key 17:1 17:0
              sleep 0.25
          done
      fi

      # 2. Try to kill the existing loop.
      # This runs only when user triggers the script (no args).
      if pkill -f "repeat_key_toggle --internal-loop"; then
          if [ -f "$NOTIFY_ID_FILE" ]; then
              LAST_ID=$(cat "$NOTIFY_ID_FILE")
              ${pkgs.libnotify}/bin/notify-send -r "$LAST_ID" -t 2000 "Powering down..."
              rm "$NOTIFY_ID_FILE"
          else
              ${pkgs.libnotify}/bin/notify-send "Powering down..."
          fi
          exit 0
      fi

      # 3. If nothing was killed and we aren't the loop, START the loop.
      ID=$(${pkgs.libnotify}/bin/notify-send -p -u critical -t 0 "Melting faces..." "Press G1 to stop")
      echo "$ID" > "$NOTIFY_ID_FILE"

      "$0" --internal-loop &
      disown
    '';
  in
  {
  home.packages = [ repeat_key_toggle ];

  omarchy.hyprland = {
    envs.YDOTOOL_SOCKET = "/run/ydotool/socket";
    bindings = [
      "bindd = CTRL, F11, Melt Faces, exec, repeat_key_toggle"
    ];
  };
}
