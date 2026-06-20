{
  flake.nixosModules.virtualization = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.virtualization;
  in {
    options.features.virtualization = {
      enable = mkEnableOption "Enable virtualization services";
    };

    config = mkIf cfg.enable {
      virtualisation.libvirtd.enable = true;
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings = {
          dns_enabled = true;
        };
      };
    };
  };
}
