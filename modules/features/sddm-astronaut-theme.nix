{self, ...}: {
  perSystem = {pkgs, ...}: {
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

      nativeBuildInputs = with pkgs; [
        qt6Packages.qtsvg
        qt6Packages.qtvirtualkeyboard
        qt6Packages.qtmultimedia
      ];

      installPhase = ''
        mkdir -p $out/share/sddm/themes/sddm-astronaut-theme
        cp -aR $src/. $out/share/sddm/themes/sddm-astronaut-theme

        mkdir -p $out/share/fonts
        cp -r $src/Fonts/. $out/share/fonts
      '';

      meta = with pkgs.lib; {
        description = "sddm-astronaut-theme is a series of themes for the SDDM display manager made by Keyitdev.";
        homepage = "https://github.com/Keyitdev/sddm-astronaut-theme";
        license = licenses.gpl3Plus;
        platforms = platforms.linux;
      };
    };
  };

  flake.nixosModules.sddm-astronaut = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.services.displayManager.sddm.astronaut;

    baseThemePkg = self.packages.${pkgs.stdenv.hostPlatform.system}.sddm-astronaut-theme;

    configuredThemePkg = pkgs.stdenv.mkDerivation {
      pname = "sddm-astronaut-theme-configured";
      inherit (baseThemePkg) version;
      src = baseThemePkg;
      dontUnpack = true;

      installPhase = ''
        mkdir -p $out
        cp -aR $src/* $out/

        chmod -R +w $out/share/sddm/themes/sddm-astronaut-theme

        sed -i 's|^ConfigFile=.*|ConfigFile=Themes/${cfg.theme}.conf|' $out/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
      '';
    };
  in {
    options.services.displayManager.sddm.astronaut = {
      enable = lib.mkEnableOption "SDDM Astronaut Theme Series";
      theme = lib.mkOption {
        type = lib.types.enum [
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
        description = "Which theme should be used for the astronaut series.";
      };
    };

    config = lib.mkIf cfg.enable {
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
