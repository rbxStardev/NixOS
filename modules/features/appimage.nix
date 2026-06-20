# ==============================================================================
# FILE: modules/features/appimage.nix
# ==============================================================================
{
  flake.nixosModules.appimage = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.appimage;
  in {
    options.features.appimage = {
      enable = mkEnableOption "Enable appimage support";
    };

    config = mkIf cfg.enable {
      programs.appimage = {
        enable = true;
        binfmt = true;
      };
    };
  };
}
