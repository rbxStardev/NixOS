# ==============================================================================
# FILE: wrappedPrograms/fastfetch.nix
# ==============================================================================
# Wraps the fastfetch CLI system information tool.
# Integrates a minimalist layout with custom NixOS/Gruvbox aesthetics.
# ==============================================================================
{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.fastfetch = {pkgs, ...}: let
    theme = self.theme;

    customLogo = pkgs.writeText "fastfetch-logo.txt" ''
           $1_   $4___    _
          $1+o\  $4\  \  / \
          $1\oo\  $4\  \/  /
        $1,oo+oo+oo$4\   ,/ $2+\
       $1<oooooooooo$4\  \ $2/os;
           $4/``/    \  $2,oo/
      $4,─~─'  /      \$2,oooooo,
      $4\__   $3;s      $2/oo/sss>`
        $4/  /$3so\$4____$2/ss/$4____
       $4`, / $3\oo\   $4```     /
        $4\/ $3/sooo\$4─~.  .─~─`
          $3/so/\oo\  $4\  \
          $3\o/  \s+\  $4\_/
                $3```
    '';
  in {
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "file";
        source = "${customLogo}";
        color = {
          "1" = theme.base0B; # Green
          "2" = theme.base0A; # Yellow
          "3" = theme.base09; # Orange
          "4" = theme.base05; # Normal Foreground
        };
        padding = {
          top = 1;
          left = 2;
          right = 4;
        };
      };

      display = {
        separator = "  ";
        color = {
          keys = "green";
          title = "yellow";
          output = "white";
        };
        key = {
          width = 10;
        };
      };

      modules = [
        {
          type = "custom";
          format = "nixos // machine";
        }
        {
          type = "separator";
          string = "----------------";
        }
        {
          type = "os";
          key = "distro";
        }
        {
          type = "kernel";
          key = "kernel";
        }
        {
          type = "uptime";
          key = "uptime";
        }
        {
          type = "packages";
          key = "pkgs";
          combined = true;
        }
        {
          type = "shell";
          key = "shell";
        }
        {
          type = "de";
          key = "desktop";
        }
        {
          type = "wm";
          key = "wm";
        }
        {
          type = "terminal";
          key = "term";
        }
        {
          type = "cpu";
          key = "cpu";
          temp = false;
          showPeCoreCount = false;
        }
        {
          type = "gpu";
          key = "gpu";
          temp = false;
        }
        {
          type = "memory";
          key = "mem";
        }
        {
          type = "disk";
          key = "disk";
          folders = "/";
          showExternal = false;
          showHidden = false;
          showSubvolumes = false;
          showReadOnly = false;
        }
        {
          type = "battery";
          key = "battery";
        }
        {
          type = "locale";
          key = "locale";
        }
        "break"
        {
          type = "colors";
          paddingLeft = 0;
          symbol = "circle";
        }
      ];
    };
  };

  perSystem = {pkgs, ...}: {
    packages.fastfetch = inputs.wrapper-modules.wrappers.fastfetch.wrap {
      inherit pkgs;
      imports = [self.wrappersModules.fastfetch];
    };
  };
}
