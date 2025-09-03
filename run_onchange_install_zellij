#!/usr/bin/env fish

switch (arch)
  case aarch64
    set URL https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-aarch64-unknown-linux-musl.tar.gz
  case '*'
    set URL https://github.com/zellij-org/zellij/releases/download/v0.43.0/zellij-x86_64-unknown-linux-musl.tar.gz   
end

echo "Downloading Zellij..."

cd (mktemp -d)

curl -L -o ./z.tgz $URL
tar zxvf ./z.tgz
mv zellij ~/bin
chmod +x ~/bin/zellij

echo "Installed Zellij"
