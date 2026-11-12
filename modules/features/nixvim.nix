{ inputs, ... }:

{
  flake-file.inputs = {
    nixvim.url = "github:nix-community/nixvim";
  };

  den.aspects.nixvim.homeManager = { config, pkgs, ... }: {
    imports = [
      inputs.nixvim.homeModules.nixvim
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.nixvim = {
      enable = true;
      enableMan = false;
      enablePrintInit = false;
      extraPackages = with pkgs; [
        nixfmt-tree
      ];

      nixpkgs.config.allowUnfree = true;

      viAlias = true;
      vimAlias = true;

      waylandSupport = true;

      withNodeJs = false;
      withPerl = false;
      withPython3 = false;
      withRuby = false;

      autoCmd = [
        {
          event = "TextYankPost";
          callback.__raw = "function() vim.highlight.on_yank({timeout = 200}) end";
        }
      ];

      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      diagnostic.settings.virtual_text = true;

      globals = {
        mapleader = " ";
        maplocalleader = "\\";
      };

      opts = {
        number = true;
        relativenumber = true;

        signcolumn = "yes";

        ignorecase = true;
        smartcase = true;

        scrolloff = 10;

        undofile = true;
        swapfile = false;

        splitright = true;
        splitbelow = true;

        updatetime = 250;
        timeoutlen = 300;

        termguicolors = true;

        expandtab = true;

        inccommand = "split";
      };

      colorschemes.onedark = {
        enable = true;
        settings = {
          style = "darker";
          diagnostics.undercurl = false;
          code_style = {
            keywords = "bold";
            functions = "bold";
          };
        };
      };

      keymaps = [
        {
          mode = [
            "n"
            "v"
          ];
          key = "j";
          action = "gj";
          options.silent = true;
        }
        {
          mode = [
            "n"
            "v"
          ];
          key = "k";
          action = "gk";
          options.silent = true;
        }
        {
          mode = [ "i" ];
          key = "jk";
          action = "<ESC>";
          options.silent = true;
        }

        ##################
        ### Bufferline ###
        ##################
        {
          mode = [ "n" ];
          key = "<S-h>";
          action = "<cmd>BufferLineCyclePrev<cr>";
          options.silent = true;
        }
        {
          mode = [ "n" ];
          key = "<S-l>";
          action = "<cmd>BufferLineCycleNext<cr>";
          options.silent = true;
        }
        {
          mode = [ "n" ];
          key = "<leader>bj";
          action = "<cmd>BufferLinePick<cr>";
          options.silent = true;
        }

        #################
        ### Telescope ###
        #################
        {
          mode = [ "n" ];
          key = "<leader>ff";
          action.__raw = ''require("telescope.builtin").find_files'';
        }
        {
          mode = [ "n" ];
          key = "<leader>fg";
          action.__raw = ''require("telescope.builtin").live_grep'';
        }
        {
          mode = [ "n" ];
          key = "<leader>fb";
          action.__raw = ''require("telescope.builtin").buffers'';
        }
        {
          mode = [ "n" ];
          key = "<leader>fh";
          action.__raw = ''require("telescope.builtin").help_tags'';
        }
        {
          mode = [ "n" ];
          key = "<leader>fr";
          action.__raw = ''require("telescope.builtin").oldfiles'';
        }
        {
          mode = [ "n" ];
          key = "<leader>fd";
          action.__raw = ''require("telescope.builtin").diagnostics'';
        }

        #############
        ### Flash ###
        #############
        {
          mode = [
            "n"
            "x"
            "o"
          ];
          key = "s";
          action.__raw = ''function() require("flash").jump() end'';
        }
        {
          mode = [
            "n"
            "x"
            "o"
          ];
          key = "S";
          action.__raw = ''function() require("flash").treesitter() end'';
        }

      ];

      lsp = {
        inlayHints.enable = true;
        inlineCompletion.enable = true;
        documentColor.enable = true;
        servers = {
          clangd.enable = true;
          nil_ls.enable = true;
          gopls.enable = true;
          tsc.enable = true;
          html.enable = true;
          css.enable = true;
          docker_language_server.enable = true;
        };
        keymaps = [
          {
            key = "gd";
            mode = "n";
            lspBufAction = "definition";
          }
          {
            key = "gD";
            mode = "n";
            lspBufAction = "declaration";
          }
          {
            key = "gr";
            mode = "n";
            lspBufAction = "references";
          }
          {
            key = "gy";
            mode = "n";
            lspBufAction = "type_definition";
          }
          {
            key = "<leader>ca";
            mode = "n";
            lspBufAction = "code_action";
          }
          {
            key = "<leader>rn";
            mode = "n";
            lspBufAction = "rename";
          }
          {
            key = "<leader>e";
            mode = "n";
            action = config.lib.nixvim.mkRaw "function() vim.diagnostic.open_float() end";
          }
          {
            key = "<leader>ih";
            mode = "n";
            action = config.lib.nixvim.mkRaw "function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end";
          }
        ];
      };

      plugins = {
        nvim-lightbulb = {
          enable = true;
          settings = {
            autocmd = {
              enabled = true;
              updatetime = 200;
            };
            virtual_text.enabled = true;
            sign.enabled = false;
          };
        };

        nvim-autopairs.enable = true;

        blink-cmp = {
          enable = true;
          settings = {
            completion.menu.border = "rounded";
            keymap = {
              preset = "enter";
              "<C-j>" = [ "select_next" ];
              "<C-k>" = [ "select_prev" ];
            };
          };
        };

        bufferline = {
          enable = true;
          settings.options.always_show_bufferline = true;
        };

        conform-nvim = {
          enable = true;
          settings = {
            formatters_by_ft = {
              c = [ "clang-format" ];
              nix = [ "treefmt" ];
              go = [
                "goimports"
                "gofumpt"
              ];
              html = [ "oxfmt" ];
              javascript = [ "oxfmt" ];
              typescript = [ "oxfmt" ];
              javascriptreact = [ "oxfmt" ];
              typescriptreact = [ "oxfmt" ];
            };
            format_on_save = {
              timeout_ms = 500;
              lsp_format = "fallback";
            };
          };
        };

        cursorline = {
          enable = true;
          settings = {
            cursorline.number = true;
            cursorword.enable = false;
          };
        };

        flash = {
          enable = true;
        };

        friendly-snippets.enable = true;

        guess-indent.enable = true;

        hlchunk = {
          enable = true;
          settings = {
            chunk = {
              enable = true;
              duration = 100;
              delay = 100;
            };
            line_num.enable = true;
            blank.enable = true;
          };
        };

        nvim-surround.enable = true;

        lspconfig.enable = true;

        rainbow-delimiters.enable = true;

        telescope = {
          enable = true;
          extensions = {
            fzf-native.enable = true;
            ui-select.enable = true;
          };
        };

        illuminate.enable = true;

        yanky.enable = true;

        grug-far.enable = true;

        oil.enable = true;

        undotree.enable = true;

        treesitter = {
          enable = true;
          highlight.enable = true;
        };

        treesitter-textobjects.enable = true;

        treesitter-context.enable = true;

        web-devicons.enable = true;

        which-key.enable = true;

        lualine.enable = true;

        fidget.enable = true;

        noice.enable = true;

        todo-comments.enable = true;

        trouble.enable = true;

        gitsigns.enable = true;
        lazygit.enable = true;
        diffview.enable = true;
        git-conflict.enable = true;

        dap.enable = true;
        dap-ui.enable = true;
        dap-go.enable = true;
        neotest.enable = true;

        persistence.enable = true;
      };
    };
  };
}
