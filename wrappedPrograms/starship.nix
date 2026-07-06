# ==============================================================================
# FILE: wrappedPrograms/starship.nix
# ==============================================================================
# Wraps and configures Starship, a cross-shell prompt, injecting a custom
# Gruvbox-based palette and module layout natively through Nix.
# ==============================================================================
{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.starship = {
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      add_newline = false;
      format = "$username $directory $character";
      palette = "gruvbox";

      username = {
        show_always = true;
        format = "[$user]($style)";
      };

      directory = {
        format = "[$path]($style)";
        style = "fg:on_dir";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          Documents = "󰈙 ";
          Downloads = " ";
          Music = " ";
          Pictures = " ";
          Videos = " ";
        };
      };

      character = {
        # Starship 1.19-style config: no "symbol" key, only success/error/vim ones
        format = "$symbol "; # use the module's symbol variable
        success_symbol = "[λ](bold green)"; # shown on success
        error_symbol = "[λ](bold red)"; # shown on error
        vicmd_symbol = "λ"; # vim normal mode (if you use it)
      };

      # Disable git info
      git_branch = {
        disabled = true;
      };

      git_status = {
        disabled = true;
      };

      # Disable language/version detectors (C, Python, node, etc.)
      c = {
        disabled = true;
      };
      nodejs = {
        disabled = true;
      };
      python = {
        disabled = true;
      };
      rust = {
        disabled = true;
      };
      golang = {
        disabled = true;
      };
      java = {
        disabled = true;
      };
      package = {
        disabled = true;
      };

      palettes = {
        gruvbox = {
          p_main = "green";
          on_p_main = "black";
          dir_bg = "black";
          on_dir = "white";
          git_bg = "blue";
          on_git = "black";
          lang_bg = "cyan";
          on_lang = "black";
          time_bg = "bright-black";
          on_time = "black";
          err = "red";
        };
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.starship =
      (inputs.wrappers.wrapperModules.starship.apply {
        inherit pkgs;
        imports = [self.wrappersModules.starship];
      }).wrapper;
  };
}
