{
  flake.nixosModules.firefox = {pkgs, ...}: {
    programs.firefox.enable = true;

    preferences.keymap = {
      "SUPER + w".package = pkgs.firefox;
    };
  };
}
