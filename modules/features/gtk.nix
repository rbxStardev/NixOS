# ==============================================================================
# FILE: modules/features/gtk.nix
# ==============================================================================
# Configures GTK 3 and GTK 4 aesthetics system-wide. Uses Gruvbox as the core
# design language and forces dark mode across GNOME/GTK applications via dconf.
# ==============================================================================
{
  flake.nixosModules.gtk = {
    pkgs,
    lib,
    config,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf mkDefault;
    cfg = config.features.gtk;

    theme-name = "Gruvbox-Green-Dark-Medium";
    theme-package = pkgs.gruvbox-gtk-theme.override {
      colorVariants = ["dark"];
      sizeVariants = ["standard"];
      themeVariants = ["green"];
    };

    icon-theme-package = pkgs.gruvbox-plus-icons;
    icon-theme-name = "Gruvbox-Plus-Dark";

    # Standardized string for INI generation
    gtksettings = ''
      [Settings]
      gtk-icon-theme-name = ${icon-theme-name}
      gtk-theme-name = ${theme-name}
    '';
  in {
    options.features.gtk = {
      enable = mkEnableOption "GTK theming and dconf profile configurations";
    };

    config = mkIf cfg.enable {
      environment = {
        etc = {
          "xdg/gtk-3.0/settings.ini".text = gtksettings;
          "xdg/gtk-4.0/settings.ini".text = gtksettings;
        };
        variables = {
          GTK_THEME = theme-name;
        };
      };

      programs.dconf = {
        enable = mkDefault true;
        profiles = {
          user = {
            databases = [
              {
                lockAll = false;
                settings = {
                  "org/gnome/desktop/interface" = {
                    gtk-theme = theme-name;
                    icon-theme = icon-theme-name;
                    color-scheme = "prefer-dark";
                  };
                };
              }
            ];
          };
        };
      };

      environment.systemPackages = [
        theme-package
        icon-theme-package
        pkgs.gtk3
        pkgs.gtk4
      ];
    };
  };
}
