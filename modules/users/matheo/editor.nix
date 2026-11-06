{ inputs, ... }:

# TODO
# - change indent-blankline underline
# - apply claude config

{
  flake-file.inputs = {
    nixvim.url = "github:nix-community/nixvim";
  };

  den.aspects.matheo.editor.homeManager = { pkgs, ... }: {
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
          mode = [
            "i"
            "x"
          ];
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

      plugins = {
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

        indent-blankline.enable = true;

        lsp = {
          enable = true;
          inlayHints = true;
          servers = {
            clangd.enable = true;
            nil_ls.enable = true;
          };
        };

        rainbow-delimiters.enable = true;

        telescope = {
          enable = true;
          extensions.fzf-native.enable = true;
        };

        treesitter = {
          enable = true;
          highlight.enable = true;
        };

        web-devicons.enable = true;
      };
    };
  };
}
