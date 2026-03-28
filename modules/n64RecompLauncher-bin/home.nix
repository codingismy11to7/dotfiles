{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = osConfig.dotfiles;
  inherit (lib) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isx86;

  version = "1.56";

  src = pkgs.fetchzip {
    url = "https://github.com/SirDiabo/N64RecompLauncher/releases/download/v${version}/N64RecompLauncher-v${version}-Linux-${
      if isx86 then "X64" else "ARM64"
    }.zip";
    hash =
      if isx86 then
        "sha256-kJxGawieH5Etrutml+WO82oAtswkOBBrC1i9tURjLS0="
      else
        "sha256-Hx+Y5lQx2Mi/ZA0yjvryWKL7zTyjK1zOthJG8wVzE74=";
    stripRoot = false;
  };

  libPath = lib.makeLibraryPath [
    pkgs.atk
    pkgs.cairo
    pkgs.fontconfig
    pkgs.freetype
    pkgs.gdk-pixbuf
    pkgs.glib
    pkgs.gtk3
    pkgs.harfbuzz
    pkgs.icu
    pkgs.pango
    pkgs.SDL2
    pkgs.stdenv.cc.cc.lib
    pkgs.xorg.libICE
    pkgs.xorg.libSM
    pkgs.xorg.libX11
    pkgs.xorg.libXcursor
    pkgs.xorg.libXext
    pkgs.xorg.libXi
    pkgs.xorg.libXrandr
  ];

  n64RecompLauncher-bin = pkgs.stdenv.mkDerivation {
    pname = "n64RecompLauncher-bin";
    inherit version src;

    nativeBuildInputs = [ pkgs.makeWrapper ];

    dontPatchELF = true;
    dontStrip = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/opt $out/bin
      cp -r . $out/opt/
      chmod +x $out/opt/N64RecompLauncher

      cat > $out/bin/N64RecompLauncher <<'WRAPPER'
      #!/usr/bin/env bash
      DATA_DIR="$HOME/.local/share/N64RecompLauncher"
      STORE_DIR="@out@/opt"
      mkdir -p "$DATA_DIR"
      cp -f "$STORE_DIR"/N64RecompLauncher "$STORE_DIR"/*.so "$STORE_DIR"/N64RecompLauncher.dll.config "$DATA_DIR"/
      echo "@version@" > "$DATA_DIR/version.txt"
      chmod -R u+w "$DATA_DIR"
      export LD_LIBRARY_PATH="$DATA_DIR:@libPath@''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      export GSETTINGS_SCHEMA_DIR="@gschemasDir@"
      exec "$DATA_DIR/N64RecompLauncher" "$@"
      WRAPPER
      chmod +x $out/bin/N64RecompLauncher
      substituteInPlace $out/bin/N64RecompLauncher \
        --replace-fail "@out@" "$out" \
        --replace-fail "@libPath@" "${libPath}" \
        --replace-fail "@gschemasDir@" "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas" \
        --replace-fail "@version@" "${version}" \

      runHook postInstall
    '';
  };
in
mkIf cfg.gaming {
  home.packages = [ n64RecompLauncher-bin ];
}
