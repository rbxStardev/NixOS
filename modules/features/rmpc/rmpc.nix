{
  flake.nixosModules.rmpc = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = [pkgs.rmpc];

    hjem.users.${config.preferences.user.name}.files = {
      ".config/rmpc/config.ron".source = ./config.ron;
      ".config/rmpc/themes/gruvbox.ron".source = ./themes/gruvbox.ron;
    };
  };
}
