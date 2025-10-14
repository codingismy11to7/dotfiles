#!/usr/bin/env fish

if command -q nix
  echo "nix is already installed, it's on you if it's misconfigured"
  exit 0
end

set -l daemon true

if ! command -q systemctl; set -e daemon; end;

set -l daemonArg "--no-daemon"
if set -q daemon; set daemonArg "--daemon"; end

set -l dlCmd curl --proto '=https' --tlsv1.2 -L
if ! command -q curl; set dlCmd wget -qO-; end

$dlCmd https://nixos.org/nix/install | sh -s -- $daemonArg

if set -q daemon
  echo ""
  echo Need to turn on flakes in /etc/nix/nix.conf
  echo about to run sudo...

  set -l nix_conf "
experimental-features = nix-command flakes
"

  echo "$nix_conf" | sudo tee -a /etc/nix/nix.conf

  echo Need to restart the nix daemon, going to run sudo

  sudo systemctl restart nix-daemon.service

else
  echo i have not run in single user mode yet so who knows what will happen
  echo ...note to later steven, this will tie in well with trying out the
  echo chezmoi deploy to container function
end

