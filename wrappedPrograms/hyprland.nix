{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.hyprland = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.hyprland;
      runtimeInputs = with pkgs; [
        hypridle
        wl-clipboard
        cliphist
        brightnessctl
        thunar
        thunar-archive-plugin
        xarchiver
      ];
      env.NIXOS_OZONE_WL = "1";
    };
  };
}
