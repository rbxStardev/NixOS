{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.hyprland = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.hyprland;
      runtimeInputs = with pkgs; [
        hypridle
      ];
      env = {
        "NIXOS_OZONE_WL" = "1";
      };
    };
  };
}
