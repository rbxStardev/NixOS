# ==============================================================================
# FILE: modules/features/zeditor.nix
# ==============================================================================
{self, ...}: {
  flake.nixosModules.zeditor = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.zeditor;
    user = config.preferences.user.name;
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";

    extensionsList = [
      "html"
      "nix"
      "toml"
      "discord-presence"
      "xml"
      "tombi"
      "lua"
      "symbols"
    ];
  in {
    options.features.zeditor = {
      enable = mkEnableOption "Zed editor configuration";
    };

    config = mkIf cfg.enable {
      environment.systemPackages = [selfpkgs.zed];

      hjem.users.${user}.files = {
        ".config/zed/tasks.json".text = builtins.toJSON [
          {
            label = "Rust: Cargo Check";
            command = "cargo check";
            description = "Quickly checks if the code compiles.";
            allow_concurrent_runs = false;
          }
          {
            label = "Rust: Cargo Run";
            command = "cargo run";
            description = "Compiles and runs the project binary.";
            allow_concurrent_runs = false;
          }
          {
            label = "Rust: Cargo Test (All)";
            command = "cargo test";
            description = "Runs all tests in the workspace.";
            allow_concurrent_runs = false;
          }
          {
            label = "Rust: Cargo Clippy";
            command = "cargo clippy --workspace --all-targets --all-features -- -D warnings";
            description = "Runs the Clippy linter, treating warnings as errors (CI default).";
            allow_concurrent_runs = false;
          }
          {
            label = "Rust: Cargo Expand";
            command = "cargo expand";
            description = "Expands macros in the current file (requires cargo-expand).";
            allow_concurrent_runs = false;
          }
          {
            label = "Nix: Cargo Build (via nix develop)";
            command = "nix develop -c cargo build";
            description = "Ensures compilation using the exact dependencies and toolchain from your flake.nix.";
            allow_concurrent_runs = false;
          }
          {
            label = "Nix: Flake Update";
            command = "nix flake update";
            description = "Updates the project's flake.lock file.";
            allow_concurrent_runs = false;
          }
          {
            label = "Nix: Format Flake";
            command = "nixfmt *.nix || alejandra *.nix";
            description = "Formats the project's Nix files using nixfmt or alejandra.";
            allow_concurrent_runs = false;
          }
        ];
        ".config/zed/settings.json".text = builtins.toJSON {
          base_keymap = "Emacs";
          vim_mode = true;

          icon_theme = {
            mode = "dark";
            light = "symbols";
            dark = "symbols";
          };
          theme = {
            mode = "dark";
            light = "Gruvbox Light Soft";
            dark = "Gruvbox Dark Hard";
          };

          ui_font_size = 14;
          buffer_font_size = 16;
          tab_bar = {show = true;};
          tabs = {show_diagnostics = "errors";};
          indent_guides = {
            enabled = true;
            coloring = "indent_aware";
          };
          inlay_hints = {enabled = true;};

          auto_install_extensions = lib.genAttrs extensionsList (_: true);

          outline_panel = {dock = "right";};
          collaboration_panel = {dock = "left";};
          notification_panel = {dock = "left";};
          auto_update = false;

          terminal = {
            alternate_scroll = "off";
            blinking = "off";
            copy_on_select = false;
            dock = "bottom";
            detect_venv = {
              on = {
                directories = [".env" "env" ".venv" "venv"];
                activate_script = "default";
              };
            };
            env = {
              EDITOR = "zeditor --wait";
              TERM = "foot";
            };
            font_family = "JetBrainsMono Nerd Font";
            font_features = null;
            line_height = "comfortable";
            option_as_meta = false;
            button = false;
            shell = "system";
            working_directory = "current_project_directory";
          };

          file_types = {
            JSON = ["json" "jsonc" "*.code-snippets"];
            XML = ["xml" "axaml" "csproj" "props" "targets"];
          };

          lsp = {
            rust-analyzer = {
              initialization_options = {
                check = {
                  command = "clippy";
                };
                inlayHints = {
                  bindingModeHints = {enable = true;};
                  closingBraceHints = {minLines = 10;};
                  closureReturnTypeHints = {enable = "with_block";};
                  discriminantHints = {enable = "fieldless";};
                  lifetimeElisionHints = {enable = "skip_trivial";};
                  typeHints = {hideNamedConstructor = true;};
                };
              };
            };

            nixd = {
              initialization_options = {
                nixpkgs = {expr = ''import (builtins.getFlake "/home/star/NixOS").inputs.nixpkgs { }'';};
                options = {
                  nixos = {expr = ''(builtins.getFlake "/home/star/NixOS").nixosConfigurations.machine.options'';};
                  "flake-parts" = {expr = ''(builtins.getFlake "/home/star/NixOS").debug.options'';};
                };
              };
            };

            lua-language-server = {
              initialization_options = {
                Lua = {
                  hint = {
                    enable = true;
                    arrayIndex = "Enable";
                    setType = true;
                    paramName = "All";
                    paramType = true;
                    await = true;
                  };
                };
              };
            };
          };

          languages = {
            Markdown = {
              formatter = "prettier";
              format_on_save = "on";
            };
            JSON = {
              formatter = "prettier";
              format_on_save = "on";
            };
            TOML = {
              formatter = "language_server";
              format_on_save = "on";
            };
            XML = {
              formatter = "language_server";
              format_on_save = "on";
            };
            Slang = {
              formatter = "language_server";
              format_on_save = "on";
            };
            Rust = {
              format_on_save = "on";
              code_actions_on_format = {
                "source.organizeImports" = true;
              };
            };
            Nix = {
              language_servers = ["nil" "nixd"];
              format_on_save = "on";
              formatter = [
                {
                  external = {
                    command = "alejandra";
                    arguments = ["--quiet" "--"];
                  };
                }
              ];
            };
            Lua = {
              language_servers = ["lua-language-server"];
              format_on_save = "on";
              formatter = [
                {
                  external = {
                    command = "stylua";
                    arguments = ["-"];
                  };
                }
              ];
            };
          };
        };
      };
    };
  };
}
