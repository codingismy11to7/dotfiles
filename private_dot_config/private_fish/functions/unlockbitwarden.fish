function unlockbitwarden
set -gx BW_SESSION (bw unlock --raw)
end
