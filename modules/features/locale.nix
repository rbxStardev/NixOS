# ==============================================================================
# FILE: modules/features/locale.nix
# ==============================================================================
# Sets up the system language, timezone, keyboard maps, and input methods (IME).
# ==============================================================================
{
  flake.nixosModules.locale = {
    pkgs,
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.locale;
  in {
    options.features.locale = {
      enable = mkEnableOption "System localization, timezones, and input methods";
    };

    config = mkIf cfg.enable {
      time.timeZone = "America/Bahia";
      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "pt_BR.UTF-8";
        LC_IDENTIFICATION = "pt_BR.UTF-8";
        LC_MEASUREMENT = "pt_BR.UTF-8";
        LC_MONETARY = "pt_BR.UTF-8";
        LC_NAME = "pt_BR.UTF-8";
        LC_NUMERIC = "pt_BR.UTF-8";
        LC_PAPER = "pt_BR.UTF-8";
        LC_TELEPHONE = "pt_BR.UTF-8";
        LC_TIME = "pt_BR.UTF-8";
      };

      console.keyMap = "br-abnt2";

      # Input Method framework, crucial for multilingual input or specific
      # layout needs inside Wayland/X11
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.addons = [pkgs.fcitx5-gtk];
      };
    };
  };
}
