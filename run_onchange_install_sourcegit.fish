#!/usr/bin/env fish

set VERSION 2025.34

switch (arch)
  case aarch64
    set ARCH arm64
  case '*'
    set ARCH amd64   
end

set URL "https://github.com/sourcegit-scm/sourcegit/releases/download/v$VERSION/sourcegit-$VERSION.linux.$ARCH.AppImage"

echo "Downloading SourceGit v$VERSION..."

curl -L -o ~/bin/sourcegit $URL

chmod +x ~/bin/sourcegit

echo "Installed SourceGit v$VERSION"
