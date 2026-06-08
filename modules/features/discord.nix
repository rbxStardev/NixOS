# ==============================================================================
# FILE: modules/features/discord.nix
# ==============================================================================
# Installs Discord and alternative clients like Vesktop (which provides better
# Wayland support and screen sharing capabilities).
# ==============================================================================
{
  flake.nixosModules.discord = {
    pkgs,
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.discord;
  in {
    options.features.discord = {
      enable = mkEnableOption "Discord and Vesktop communication clients";
    };

    config = mkIf cfg.enable {
      environment.systemPackages = [
        pkgs.vesktop
        pkgs.discord
      ];
    };
  };
}
