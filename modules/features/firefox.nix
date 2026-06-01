{
  flake.nixosModules.firefox = {pkgs, ...}: {
    programs.firefox.enable = true;
  };
}
