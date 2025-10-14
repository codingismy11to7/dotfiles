#!/usr/bin/env fish

echo "downloading fonts..."

echo "MesloLGS NF"

set BASE https://github.com/romkatv/powerlevel10k-media/raw/master/

mkdir -p ~/.local/share/fonts

cd (mktemp -d)
for f in MesloLGS%20NF%20Regular.ttf MesloLGS%20NF%20Bold.ttf MesloLGS%20NF%20Italic.ttf MesloLGS%20NF%20Bold%20Italic.ttf
    wget $BASE$f
end
mv *.ttf ~/.local/share/fonts/

echo "FiraCode"

cd (mktemp -d)
curl -L -o fc.zip https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip
unzip fc.zip
mv ./ttf/* ~/.local/share/fonts/

echo "FiraCode Nerd Font"

cd (mktemp -d)
curl -L -o fcnf.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
unzip fcnf.zip
mv *.ttf ~/.local/share/fonts/

if command -q fc-cache
  echo "Updating font cache..."
  fc-cache -f -v
end

echo "done"
