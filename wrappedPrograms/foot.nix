{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.foot = {
    config,
    lib,
    ...
  }: let
    colors = self.themeNoHash;
  in {
    options.shell = lib.mkOption {
      type = lib.types.str;
      default = "";
    };

    config = {
      settings = {
        main = {
          shell = lib.mkIf (config.shell != "") config.shell;

          font = "JetBrainsMono Nerd Font:size=12";
        };

        cursor = {
          style = "beam";
          blink = "no";
        };

        scrollback = {
          lines = 10000;
        };

        colors-dark = {
          alpha = "0.78";

          background = colors.base00;
          foreground = colors.base07;

          regular0 = colors.base00; # black
          regular1 = colors.base08; # red
          regular2 = colors.base0B; # green
          regular3 = colors.base0A; # yellow
          regular4 = colors.base0D; # blue
          regular5 = colors.base0E; # magenta
          regular6 = colors.base0C; # cyan
          regular7 = colors.base03; # white

          bright0 = colors.base02; # bright black
          bright1 = colors.base08; # bright red
          bright2 = colors.base0B; # bright green
          bright3 = colors.base0A; # bright yellow
          bright4 = colors.base0D; # bright blue
          bright5 = colors.base0E; # bright magenta
          bright6 = colors.base0C; # bright cyan
          bright7 = colors.base03; # bright white
        };
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.foot =
      (inputs.wrappers.wrapperModules.foot.apply {
        inherit pkgs;
        imports = [self.wrappersModules.foot];
      }).wrapper;
  };
}
