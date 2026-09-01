# TEMPORARY — delete this file once nixpkgs ships obscura >= 0.2.1.
#
# The pinned nixpkgs-unstable has obscura 0.2.0, which strands the active page
# between MCP tool calls: timers, fetches, and queued navigations don't run
# until the next call. Upstream fixed that in 0.2.1 (#618, #640, released
# 2026-08-23), and the mcp subcommand is the reason we want this package at all.
#
# This rebuilds the nixpkgs expression at the 0.2.1 tag rather than vendoring a
# copy of it, so we keep upstream's patches, install check, and V8 handling. The
# v8 crate is unchanged across 0.2.0 -> 0.2.1 (137.3.0 in both Cargo.locks), so
# the separately-pinned librusty_v8 archive still matches and is reused as-is.
#
# To revert: delete this file, then drop the obscuraWithMcpFix binding and
# restore the plain `obscura` one-liner in home.nix.
{
  obscura,
  fetchFromGitHub,
  rustPlatform,
}:
let
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "h4ckf0r0day";
    repo = "obscura";
    rev = "v${version}";
    hash = "sha256-sA9sRjcovJGGVDzNuy4AYTUkQ4SZlHAKH3B/azWQlqk=";
  };
in
obscura.overrideAttrs (old: {
  inherit version src;

  # buildRustPackage takes cargoHash from its own call args, which overrideAttrs
  # cannot reach — setting `cargoHash` here is silently ignored and the vendor
  # dir keeps 0.2.0's hash. Rebuilding cargoDeps by hand is the way through.
  cargoDeps = rustPlatform.fetchCargoVendor {
    pname = "obscura";
    inherit version src;
    hash = "sha256-e4zVkknVcCs0qhqxLGTBDL606WZ88GWEZo1O934O3eU=";
  };

  # Upstream's expression bakes OBSCURA_VERSION from its own `version`, so
  # without this `obscura --version` reports 0.2.0 and versionCheckHook fails.
  env = old.env // {
    OBSCURA_VERSION = version;
  };
})
