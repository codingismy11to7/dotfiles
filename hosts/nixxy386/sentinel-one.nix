{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.sentinelone.nixosModules.sentinelone
  ];

  sops.secrets.s1MgmtToken = { };

  services.sentinelone = {
    enable = true;
    sentinelOneManagementTokenPath = config.sops.secrets.s1MgmtToken.path;
    package = inputs.sentinelone.packages.x86_64-linux.sentinelone.overrideAttrs {
      version = "25.4.1.24";
      src = pkgs.fetchurl {
        url = "https://codingismy11to7.us/SentinelAgent_linux_x86_64_v25_4_1_24.deb";
        sha256 = "1a8gki5si5ksjdywsa37216qp1iiamciixijh0nh64k29nf431vm";
      };
    };
  };
}
