# ==============================================================================
# FILE: modules/base/user.nix
# ==============================================================================
# Defines the global user preferences. This is crucial as it avoids hardcoding
# the username throughout the entire system configuration.
# ==============================================================================
{
  flake.nixosModules.base = {lib, ...}: let
    inherit (lib) mkOption types;
  in {
    options.preferences = {
      user.name = mkOption {
        type = types.str;
        default = "star";
        description = "The primary username used across the NixOS configuration and home paths.";
      };
    };
  };
}
