function unlockbitwarden
    set -Ux BW_SESSION (bw unlock --raw)
end
