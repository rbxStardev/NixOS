# ==============================================================================
# FILE: modules/features/firefox.nix
# ==============================================================================
# Configures the Firefox browser, applying specific preferences to enforce
# native Wayland behavior and XDG Desktop Portal integration.
# ==============================================================================
{
  flake.nixosModules.firefox = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.firefox;
  in {
    options.features.firefox = {
      enable = mkEnableOption "Firefox browser with native Wayland integrations";
    };

    config = mkIf cfg.enable {
      programs.firefox = {
        enable = true;
      };
    };
  };
}
