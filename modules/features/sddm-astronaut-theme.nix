# ==============================================================================
# FILE: modules/features/sddm-astronaut-theme.nix
# ==============================================================================
# Fetches, builds, and configures the highly customizable "Astronaut" theme
# for the SDDM Display Manager. Modifies the underlying derivation to inject
# user-selected theme variants dynamically.
# ==============================================================================
{self, ...}: {
  # ----------------------------------------------------------------------------
  # Package Definition
  # ----------------------------------------------------------------------------
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.sddm-astronaut-theme = pkgs.stdenv.mkDerivation {
      pname = "sddm-astronaut-theme";
      version = "d73842c761f7d7859f3bdd80e4360f09180fad41";

      src = pkgs.fetchFromGitHub {
        owner = "Keyitdev";
        repo = "sddm-astronaut-theme";
        rev = "d73842c761f7d7859f3bdd80e4360f09180fad41";
        hash = "sha256-+94WVxOWfVhIEiVNWwnNBRmN+d1kbZCIF10Gjorea9M=";
      };

      dontBuild = true;
      dontWrapQtApps = true;

      # Explicit dependencies required by the QML components of the theme
      nativeBuildInputs = [
        pkgs.qt6Packages.qtsvg
        pkgs.qt6Packages.qtvirtualkeyboard
        pkgs.qt6Packages.qtmultimedia
      ];

      installPhase = ''
        mkdir -p $out/share/sddm/themes/sddm-astronaut-theme
        cp -aR $src/. $out/share/sddm/themes/sddm-astronaut-theme

        mkdir -p $out/share/fonts
        cp -r $src/Fonts/. $out/share/fonts
      '';

      meta = {
        description = "SDDM Astronaut Theme Series made by Keyitdev.";
        homepage = "https://github.com/Keyitdev/sddm-astronaut-theme";
        license = lib.licenses.gpl3Plus;
        platforms = lib.platforms.linux;
      };
    };
  };

  # ----------------------------------------------------------------------------
  # NixOS Module Integration
  # ----------------------------------------------------------------------------
  flake.nixosModules.sddm-astronaut = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) mkEnableOption mkOption types mkIf;
    cfg = config.services.displayManager.sddm.astronaut;

    baseThemePkg = self.packages.${pkgs.stdenv.hostPlatform.system}.sddm-astronaut-theme;

    # A wrapper derivation that alters the configuration file within the theme
    # directory before injecting it into the system, avoiding read-only errors.
    configuredThemePkg = pkgs.stdenv.mkDerivation {
      pname = "sddm-astronaut-theme-configured";
      inherit (baseThemePkg) version;
      src = baseThemePkg;
      dontUnpack = true;

      installPhase = ''
        mkdir -p $out
        cp -aR $src/* $out/

        # Grant write permissions to modify the metadata file
        chmod -R +w $out/share/sddm/themes/sddm-astronaut-theme

        # Replace the default config pointer with the user-selected variant
        sed -i 's|^ConfigFile=.*|ConfigFile=Themes/${cfg.theme}.conf|' $out/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
      '';
    };
  in {
    options.services.displayManager.sddm.astronaut = {
      enable = mkEnableOption "SDDM Astronaut Theme Series integration";

      theme = mkOption {
        type = types.enum [
          "astronaut"
          "black_hole"
          "cyberpunk"
          "hyprland_kath"
          "jake_the_dog"
          "japanese_aesthetic"
          "pixel_sakura"
          "pixel_sakura_static"
          "post-apocalyptic_hacker"
          "purple_leaves"
        ];
        default = "astronaut";
        description = "Specifies which specific variation of the astronaut theme to apply.";
      };
    };

    config = mkIf cfg.enable {
      services.displayManager.sddm.theme = "sddm-astronaut-theme";

      environment.systemPackages = [
        configuredThemePkg
        pkgs.qt6Packages.qtsvg
        pkgs.qt6Packages.qtvirtualkeyboard
        pkgs.qt6Packages.qtmultimedia
      ];
    };
  };
}
