{self, ...}: {
  flake.nixosModules.hyprland = {
    pkgs,
    config,
    ...
  }: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    user = config.preferences.user.name;
  in {
    programs.hyprland = {
      enable = true;
      package = selfpkgs.hyprland;
      withUWSM = true;
    };

    hjem.users.${user}.files = {
      ".config/hypr/hyprland.lua".source = ./hyprland.lua;
      ".config/hypr/variables.lua".source = ./variables.lua;
      ".config/hypr/settings".source = ./settings;

      # Explicit initialization replaces the fragile builtins.readDir logic.
      # This ensures predictable loading order and prevents crashes if non-Lua
      # or temporary files are accidentally placed in the settings directory.
      ".config/hypr/settings_init.lua".text = ''
        require("settings.env")
        require("settings.theme")
        require("settings.animations")
        require("settings.decoration")
        require("settings.general")
        require("settings.gestures")
        require("settings.group")
        require("settings.input")
        require("settings.misc")
        require("settings.rules")
        require("settings.scrolling")
        require("settings.noctalia")
        require("settings.execs")
        require("settings.keybinds")
      '';
    };
  };
}
