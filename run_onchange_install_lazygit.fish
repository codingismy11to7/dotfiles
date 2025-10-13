#!/usr/bin/env fish

set VERSION 0.55.1

switch (arch)
  case aarch64
    set ARCH arm64
  case '*'
    set ARCH x86_64
end

set URL "https://github.com/jesseduffield/lazygit/releases/download/v"$VERSION"/lazygit_"$VERSION"_linux_"$ARCH".tar.gz"

echo "Downloading LazyGit v$VERSION..."

cd (mktemp -d)

curl -L -o ./lg.tgz $URL
tar zxf ./lg.tgz
mv **/lazygit ~/bin
chmod +x ~/bin/lazygit

echo "Installed LazyGit v$VERSION"
