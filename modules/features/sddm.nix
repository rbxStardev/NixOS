# ==============================================================================
# FILE: modules/features/sddm.nix
# ==============================================================================
# Configures the sddm login manager and astronaut theme
# ==============================================================================
{self, ...}: {
  flake.nixosModules.sddm = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.sddm;
  in {
    options.features.sddm = {
      enable = mkEnableOption "Sddm + Astronaut theme setup";
    };

    config = mkIf cfg.enable {
      services.displayManager.sddm = {
        enable = true;
        astronaut = {
          enable = true;
          theme = "japanese_aesthetic";
        };
      };
    };
  };
}
