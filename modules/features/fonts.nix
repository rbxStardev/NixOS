# ==============================================================================
# FILE: modules/features/fonts.nix
# ==============================================================================
# Installs and configures system-wide fonts. Sets up default fallback families
# for serif, sans-serif, and monospace rendering to ensure consistent UI scaling.
# ==============================================================================
{
  flake.nixosModules.fonts = {
    pkgs,
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.fonts;
  in {
    options.features.fonts = {
      enable = mkEnableOption "System-wide fonts and default typography configs";
    };

    config = mkIf cfg.enable {
      fonts.packages = [
        # Modern Nerd Fonts are scoped under the nerd-fonts attribute set
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.ubuntu-sans
        pkgs.cm_unicode
        pkgs.corefonts
        pkgs.unifont
      ];

      # Configure fontconfig to use our installed fonts as defaults
      fonts.fontconfig.defaultFonts = {
        serif = ["Ubuntu Sans"];
        sansSerif = ["Ubuntu Sans"];
        monospace = ["JetBrainsMono Nerd Font"];
      };
    };
  };
}
