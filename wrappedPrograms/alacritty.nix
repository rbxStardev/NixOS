# ==============================================================================
# FILE: wrappedPrograms/alacritty.nix
# ==============================================================================
# Wraps Alacritty terminal emulator, injecting custom fonts, opacities, and
# an external Gruvbox theme from a flake input.
# ==============================================================================
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
    # Custom option to allow overriding the default shell
    options.shell = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Path to the default shell executable to run inside Alacritty.";
    };

    config = {
      settings = {
        # Only inject the shell configuration if the option is explicitly set
        terminal = lib.mkIf (config.shell != "") {
          shell = {
            program = config.shell;
          };
        };

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

  perSystem = {
    pkgs,
    system,
    ...
  }: {
    packages.alacritty =
      (inputs.wrappers.wrapperModules.alacritty.apply {
        inherit pkgs;
        imports = [
          self.wrappersModules.alacritty

          # Import the Gruvbox Dark theme dynamically from the alacritty-theme input
          {
            config.settings.general.import = [
              "${inputs.alacritty-theme.packages.${system}.gruvbox_dark}"
            ];
          }
        ];
      }).wrapper;
  };
}
