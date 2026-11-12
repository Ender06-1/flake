{ den, ... }:

{
  den.aspects.matheo.cli = {
    includes = [
      (den.batteries.user-shell "fish")
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nix-inspect
          bat
          fastfetch

          # yazi deps
          p7zip
          ffmpeg
          jq
          fd
          ripgrep
          fzf
          resvg
          wl-clipboard
          imagemagick
        ];

        programs.lazygit.enable = true;

        programs.btop = {
          enable = true;
          settings.update_ms = 1000;
        };

        programs.eza = {
          enable = true;
          colors = "always";
          extraOptions = [
            "--group-directories-first"
            "--header"
            "--hyperlink"
            "--smart-group"
          ];
          git = true;
          icons = "always";
        };

        programs.fish = {
          enable = true;
          plugins = with pkgs.fishPlugins; [
            {
              name = "puffer";
              src = puffer.src;
            }
          ];
          shellAliases = {
            nvimf = "nvim (fzf)";
            llg = "ll --git-ignore";
            ltg = "lt -a --git-ignore";
          };
          interactiveShellInit =
            let
              black = "282c34";
              white = "abb2bf";
              lightRed = "e06c75";
              darkRed = "be5046";
              green = "98c379";
              lightYellow = "e5c07b";
              darkYellow = "d19a66";
              blue = "61afef";
              magenta = "c678dd";
              cyan = "56b6c2";
              gutterGrey = "4b5263";
              commentGrey = "5c6370";
            in
            ''
              set fish_greeting

              set -g fish_color_normal ${white}
              set -g fish_color_command ${green} --bold
              set -g fish_color_builtin ${lightYellow} --bold
              set -g fish_color_quote ${darkYellow}
              set -g fish_color_redirection ${cyan}
              set -g fish_color_end ${gutterGrey}
              set -g fish_color_error ${lightRed}
              set -g fish_color_param ${blue}
              set -g fish_color_comment ${commentGrey}
              set -g fish_color_match ${cyan} --underline
              set -g fish_color_selection --background=${gutterGrey}
              set -g fish_color_search_match --background=${blue}
              set -g fish_color_operator ${magenta}
              set -g fish_color_escape ${lightYellow}
              set -g fish_color_cwd ${blue}
              set -g fish_color_autosuggestion ${gutterGrey}
              set -g fish_color_valid_path ${magenta} --underline
              set -g fish_color_history_current ${cyan}
              set -g fish_color_user ${blue}
              set -g fish_color_host ${green}
              set -g fish_color_cancel ${gutterGrey}
            '';
        };

        programs.fzf.enable = true;

        programs.git = {
          enable = true;
          settings = {
            init.defaultBranch = "main";
            user = {
              name = "Ender";
              email = "ndxendernight@gmail.com";
            };
          };
        };

        programs.nh.enable = true;

        programs.starship = {
          enable = true;
          enableTransience = true;
          presets = [ "nerd-font-symbols" ];
        };

        programs.yazi.enable = true;

        programs.zellij = {
          enable = true;
          settings = {
            theme = "onedark";
            show_startup_tips = false;
            pane_frame_style = "full";
            default_mode = "locked";
          };
        };

        programs.zoxide.enable = true;

        programs.direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

        programs.ssh = {
          enable = true;
          enableDefaultConfig = false;
          settings."*".AddKeysToAgent = "yes";
        };

        services.ssh-agent.enable = true;

        services.podman = {
          enable = true;
          enableTypeChecks = true;
        };
      };
  };
}
