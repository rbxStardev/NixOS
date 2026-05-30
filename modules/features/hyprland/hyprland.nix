{self, ...}: {
  flake.nixosModules.hyprland = {
    pkgs,
    config,
    ...
  }: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    user = config.preferences.user.name;
  in {
    programs.hyprland.enable = true;
    programs.hyprland.package = selfpkgs.hyprland;

    hjem.users.${user}.files = {
      ".config/hypr/hyprland.lua".source = ./hyprland.lua;
      ".config/hypr/variables.lua".source = ./variables.lua;
      ".config/hypr/settings".source = ./settings;
      ".config/hypr/settings_init.lua".text = let
        luaFiles =
          builtins.filter (f: builtins.match ".*\\.lua" f != null)
          (builtins.attrNames (builtins.readDir ./settings));
        requires = map (f: ''require("settings.${builtins.replaceStrings [".lua"] [""] f}")'') luaFiles;
      in
        ''require("theme")'' + "\n" + builtins.concatStringsSep "\n" requires;
    };
  };
}
