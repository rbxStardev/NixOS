{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.alacritty = {
    config,
    lib,
    ...
  }: {
    options.shell = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    config = {
      args = lib.mkAfter (lib.optionals (config.shell != "") [config.shell]);
      settings = {
        font = {
          bold = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Italic";
          };
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          size = 12;
        };
        window = {
          opacity = 0.78;
        };
        cursor = {
          style = {
            shape = "Beam";
            blinking = "Never";
          };
        };
        scrolling.history = 10000;
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.alacritty =
      (inputs.wrappers.wrapperModules.alacritty.apply {
        inherit pkgs;
        imports = [self.wrappersModules.alacritty];
      }).wrapper;
  };
}
