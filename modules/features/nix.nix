{inputs, ...}: {
  flake.nixosModules.nix = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];
    programs.nix-index-database.comma.enable = true;

    programs.direnv = {
      enable = true;
      silent = true;
      loadInNixShell = true;
      direnvrcExtra = "";
      nix-direnv = {
        enable = true;
      };
    };

    programs.nh = {
      enable = true;
      flake = "/home/${config.preferences.user.name}/NixOS";
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 3";
      };
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings.auto-optimise-store = true;
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      nil
      nixd
      statix
      alejandra
      manix
      nix-inspect
    ];
  };
}
