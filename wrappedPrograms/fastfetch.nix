# ==============================================================================
# FILE: wrappedPrograms/fastfetch.nix
# ==============================================================================
# Wraps the fastfetch CLI system information tool.
# Injects a custom ASCII logo and configures the output layout to match the
# Gruvbox theme provided by the global flake configuration.
# ==============================================================================
{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.fastfetch = {pkgs, ...}: let
    theme = self.theme;

    # Custom ASCII logo defining color markers mapped to fastfetch JSON later
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
        # Maps the $1, $2, $3, $4 markers in the ASCII art to our theme hex codes
        color = {
          "1" = theme.base0B; # Green
          "2" = theme.base0A; # Yellow
          "3" = theme.base09; # Orange
          "4" = theme.base05; # Normal Foreground
        };
        padding = {
          top = 8;
          left = 3;
          right = 4;
        };
      };

      modules = [
        "break"
        {
          type = "custom";
          format = "┌──────────────────────Hardware───────────────────────┐";
        }
        {
          type = "host";
          key = "󰌢  PC";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "│ ├󰻠 ";
          keyColor = "green";
        }
        {
          type = "gpu";
          key = "│ ├󰍹 ";
          keyColor = "green";
        }
        {
          type = "memory";
          key = "│ ├󰑭 ";
          keyColor = "green";
        }
        {
          type = "disk";
          key = "└ └󰋊 ";
          keyColor = "green";
        }
        {
          type = "custom";
          format = "└─────────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "┌──────────────────────Software───────────────────────┐";
        }
        {
          type = "os";
          key = "  OS";
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = "│ ├󰌽 ";
          keyColor = "yellow";
        }
        {
          type = "bios";
          key = "│ ├󰖡 ";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "│ ├󰏗 ";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "└ └󰞷 ";
          keyColor = "yellow";
        }
        "break"
        {
          type = "de";
          key = "󰧨  DE";
          keyColor = "blue";
        }
        {
          type = "lm";
          key = "│ ├󰍁 ";
          keyColor = "blue";
        }
        {
          type = "wm";
          key = "│ ├󱂬 ";
          keyColor = "blue";
        }
        {
          type = "wmtheme";
          key = "│ ├󰉦 ";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = "└ └󰆍 ";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "└─────────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "┌──────────────────Uptime / Age / DT──────────────────┐";
        }
        {
          type = "command";
          key = "  ›  OS Age  ";
          keyColor = "magenta";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          type = "uptime";
          key = "  ›  Uptime  ";
          keyColor = "magenta";
        }
        {
          type = "datetime";
          key = "  ›  DateTime  ";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "└─────────────────────────────────────────────────────┘";
        }
        {
          type = "colors";
          paddingLeft = 2;
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
