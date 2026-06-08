# ==============================================================================
# FILE: modules/features/chromium.nix
# ==============================================================================
# Configures the ungoogled-chromium browser, providing a privacy-respecting
# web experience integrated with the system.
# ==============================================================================
{
  flake.nixosModules.chromium = {
    pkgs,
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.chromium;
  in {
    options.features.chromium = {
      enable = mkEnableOption "Ungoogled Chromium browser setup";
    };

    config = mkIf cfg.enable {
      # Enables underlying policies and integrations for Chromium-based browsers
      programs.chromium.enable = true;

      environment.systemPackages = [
        pkgs.ungoogled-chromium
      ];
    };
  };
}
