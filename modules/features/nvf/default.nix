# ==============================================================================
# FILE: modules/features/nvf/default.nix
# ==============================================================================
{inputs, ...}: {
  flake.nixosModules.nvf = {
    pkgs,
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.nvf;
  in {
    options.features.nvf = {
      enable = mkEnableOption "Enable NVF for NeoVim";
    };

    imports = [
      inputs.nvf.nixosModules.default
    ];

    config = mkIf cfg.enable {
      programs.nvf = {
        enable = true;
        settings = {
          vim = {
            clipboard = {
              enable = true;
              providers.wl-copy.enable = true;
              registers = "unnamedplus";
            };

            formatter.conform-nvim = {
              enable = true;
              setupOpts = {
                format_on_save = {
                  timeout_ms = 500;
                  lsp_format = "fallback";
                };
              };
            };

            presence.neocord.enable = true;

            options = {
              softtabstop = 4;
              tabstop = 4;
              shiftwidth = 4;
              expandtab = true;
              relativenumber = true;
              number = true;
              ignorecase = true;
              smartcase = true;
              termguicolors = true;
              splitright = true;
              splitbelow = true;
              swapfile = false;
              backup = false;
              undofile = true;
              scrolloff = 8;
              signcolumn = "yes";
              updatetime = 50;
              foldcolumn = "1";
              foldlevel = 99;
              foldlevelstart = 99;
              foldenable = true;
            };

            globals = {
              mapleader = " ";
            };

            keymaps = [
              {
                key = "<C-u>";
                mode = "n";
                action = "<C-u>zz";
              }
              {
                key = "<C-d>";
                mode = "n";
                action = "<C-d>zz";
              }
              {
                key = "<leader>sv";
                mode = "n";
                action = "<C-w>v";
                desc = "Split vertical";
              }
              {
                key = "<leader>sh";
                mode = "n";
                action = "<C-w>s";
                desc = "Split horizontal";
              }
              {
                key = "<leader>se";
                mode = "n";
                action = "<C-w>=";
                desc = "Equalize splits";
              }
              {
                key = "<leader>sx";
                mode = "n";
                action = ":close<CR>";
                desc = "Close split";
              }

              {
                key = "<leader>to";
                mode = "n";
                action = ":tabnew<CR>";
                desc = "Open new tab";
              }
              {
                key = "<leader>tx";
                mode = "n";
                action = ":tabclose<CR>";
                desc = "Close tab";
              }
              {
                key = "<leader>tn";
                mode = "n";
                action = ":tabn<CR>";
                desc = "Next tab";
              }
              {
                key = "<leader>tp";
                mode = "n";
                action = ":tabp<CR>";
                desc = "Prev tab";
              }

              {
                key = "<leader>x";
                mode = "n";
                action = "<cmd>Bdelete<CR>";
                desc = "Close Buffer";
              }

              {
                key = "<leader>fc";
                mode = "n";
                action = "<cmd>Telescope grep_string<CR>";
                desc = "Find word under cursor";
              }

              {
                key = "J";
                mode = "v";
                action = ":m '>+1<CR>gv=gv";
                desc = "Move block down";
                silent = true;
              }
              {
                key = "K";
                mode = "v";
                action = ":m '<-2<CR>gv=gv";
                desc = "Move block up";
                silent = true;
              }

              {
                key = "<leader>dc";
                mode = "n";
                action = "<cmd>lua require('dap').continue()<CR>";
                desc = "DAP Continue";
              }
              {
                key = "<leader>db";
                mode = "n";
                action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
                desc = "DAP Toggle Breakpoint";
              }
              {
                key = "<leader>ds";
                mode = "n";
                action = "<cmd>lua require('dap').step_over()<CR>";
                desc = "DAP Step Over";
              }
              {
                key = "<leader>di";
                mode = "n";
                action = "<cmd>lua require('dap').step_into()<CR>";
                desc = "DAP Step Into";
              }
              {
                key = "<leader>do";
                mode = "n";
                action = "<cmd>lua require('dap').step_out()<CR>";
                desc = "DAP Step Out";
              }
              {
                key = "<leader>du";
                mode = "n";
                action = "<cmd>lua require('dapui').toggle()<CR>";
                desc = "DAP UI Toggle";
              }

              {
                key = "<leader>dc";
                mode = "n";
                action = "<cmd>lua require('dap').continue()<CR>";
                desc = "DAP Continue";
              }

              {
                key = "<leader>d";
                mode = "n";
                action = "<cmd>lua vim.diagnostic.open_float()<CR>";
                desc = "Show line diagnostics";
              }
              {
                key = "<leader>D";
                mode = "n";
                action = "<cmd>Telescope diagnostics bufnr=0<CR>";
                desc = "Show buffer diagnostics";
              }
              {
                key = "[d";
                mode = "n";
                action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
                desc = "Go to previous diagnostic";
              }
              {
                key = "]d";
                mode = "n";
                action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
                desc = "Go to next diagnostic";
              }

              {
                key = "<leader>xx";
                mode = "n";
                action = "<cmd>Trouble diagnostics toggle<CR>";
                desc = "Toggle Trouble Diagnostics";
              }
            ];

            theme = {
              enable = true;
              name = "gruvbox";
              style = "dark";
            };

            dashboard.alpha.enable = true;
            autopairs.nvim-autopairs.enable = true;

            tabline.nvimBufferline = {
              enable = true;
              mappings = {
                cycleNext = "<Tab>";
                cyclePrevious = "<S-Tab>";
              };
            };

            statusline.lualine = {
              enable = true;
              theme = "gruvbox";
            };

            telescope = {
              enable = true;
              mappings = {
                findFiles = "<leader>ff";
                liveGrep = "<leader>fw";
                buffers = "<leader>fb";
                helpTags = "<leader>fh";
              };
            };

            filetree.nvimTree = {
              enable = true;
              openOnSetup = false;
              setupOpts = {
                view = {
                  side = "left";
                  width = 35;
                };
              };
              mappings = {toggle = "<C-n>";};
            };

            notes.obsidian = {
              enable = true;
              setupOpts = {
                dir = "~/vaults/personal";
                bullet_manager = true;
                completion = {
                  nvim_cmp = true;
                  min_chars = 2;
                };
              };
            };

            debugger.nvim-dap = {
              enable = true;
              ui.enable = true;
            };

            autocomplete.nvim-cmp.enable = true;
            snippets.luasnip.enable = true;

            lsp = {
              enable = true;
              inlayHints.enable = true;
              mappings = {
                codeAction = "<leader>ca";
                renameSymbol = "<leader>rn";
              };

              servers = {
                nixd = {
                  enable = true;
                  settings = {
                    nixd = {
                      nixpkgs = {
                        expr = ''import (builtins.getFlake "/home/star/NixOS").inputs.nixpkgs { }'';
                      };
                      options = {
                        nixos = {
                          expr = ''(builtins.getFlake "/home/star/NixOS").nixosConfigurations.machine.options'';
                        };
                        "flake-parts" = {
                          expr = ''(builtins.getFlake "/home/star/NixOS").debug.options'';
                        };
                      };
                    };
                  };
                };

                rust_analyzer = {
                  enable = true;
                  settings = {
                    "rust-analyzer" = {
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
                };

                lua_ls = {
                  enable = true;
                  settings = {
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
            };

            languages = {
              enableFormat = true;
              enableTreesitter = true;

              rust = {
                enable = true;
                extensions.crates-nvim.enable = true;
                dap.enable = true;
              };
              toml = {
                enable = true;
                format.type = ["tombi"];
                lsp.servers = ["tombi"];
              };
              lua.enable = true;
              nix = {
                enable = true;
                lsp.servers = ["nixd"];
              };
              markdown = {
                enable = true;
                extensions.render-markdown-nvim.enable = true;
              };
            };

            extraPlugins = with pkgs.vimPlugins; {
              nvim-ufo = {
                package = nvim-ufo;
                setup = "require('ufo').setup()";
              };
              bufdelete-nvim = {
                package = bufdelete-nvim;
              };
              nvim-dap-virtual-text = {
                package = nvim-dap-virtual-text;
                setup = "require('nvim-dap-virtual-text').setup({})";
              };
              nvim-surround = {
                package = nvim-surround;
                setup = "require('nvim-surround').setup({})";
              };
              todo-comments-nvim = {
                package = todo-comments-nvim;
                setup = "require('todo-comments').setup({})";
              };
              trouble-nvim = {
                package = trouble-nvim;
                setup = "require('trouble').setup({})";
              };
              nvim-colorizer-lua = {
                package = nvim-colorizer-lua;
                setup = "require('colorizer').setup()";
              };
              dressing-nvim = {package = dressing-nvim;};
              smear-cursor-nvim = {package = smear-cursor-nvim;};
              satellite-nvim = {package = satellite-nvim;};
            };

            luaConfigRC.dynamic-indent = ''
              local filetypes_2_spaces = {
                "nix", "lua", "javascript", "typescript",
                "javascriptreact", "typescriptreact",
                "html", "css", "json", "yaml", "markdown"
              }

              vim.api.nvim_create_autocmd("FileType", {
                pattern = filetypes_2_spaces,
                callback = function()
                  vim.opt_local.shiftwidth = 2
                  vim.opt_local.tabstop = 2
                  vim.opt_local.softtabstop = 2
                  vim.opt_local.expandtab = true
                end,
              })

              vim.api.nvim_create_autocmd("FileType", {
                pattern = { "make", "go" },
                callback = function()
                  vim.opt_local.expandtab = false
                  vim.opt_local.shiftwidth = 4
                  vim.opt_local.tabstop = 4
                  vim.opt_local.softtabstop = 4
                end,
              })
            '';
            luaConfigRC.star-tools = ''
              local alpha = require("alpha")
              local dashboard = require("alpha.themes.dashboard")

              dashboard.section.header.val = {
                [[                                                                      ]],
                [[        ███████████           █████      ██                     ]],
                [[       ███████████             █████                             ]],
                [[       ████████████████ ███████████ ███   ███████     ]],
                [[      ████████████████ ████████████ █████ ██████████████   ]],
                [[     █████████████████████████████ █████ █████ ████ █████   ]],
                [[   ██████████████████████████████████ █████ █████ ████ █████  ]],
                [[  ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
                [[  ██████   ██  ███████████████   ██ █████████████████ ]],
                [[  ██████   ██   ███████████████   ██ █████████████████ ]],
              }

              dashboard.section.buttons.val = {
                dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
                dashboard.button("f", " > Find file", "<cmd>Telescope find_files<CR>"),
                dashboard.button("CTRL N", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
                dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
                dashboard.button("SPC fw", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
                dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
              }

              alpha.setup(dashboard.opts)

              vim.api.nvim_create_autocmd("FileType", {
                pattern = "alpha",
                callback = function()
                  vim.opt_local.foldenable = false
                end,
              })

              local skeleton = (function()
                ${builtins.readFile ./lua/star/tools/skeleton.lua}
              end)()

              vim.api.nvim_create_autocmd("BufNewFile", {
                  pattern = { "*.rs" },
                  callback = function()
                      if skeleton and skeleton.insert then
                          skeleton.insert()
                      end
                  end,
              })
            '';
          };
        };
      };
    };
  };
}
