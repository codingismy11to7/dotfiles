#!/usr/bin/env fish

set VERSION 0.43.1

set URL https://github.com/zellij-org/zellij/releases/download/v{$VERSION}/zellij-(arch)-unknown-linux-musl.tar.gz

echo "Downloading Zellij v$VERSION..."

cd (mktemp -d)

curl -L -o ./z.tgz $URL
tar zxf ./z.tgz
mv zellij ~/bin
chmod +x ~/bin/zellij

echo "Installed Zellij"
