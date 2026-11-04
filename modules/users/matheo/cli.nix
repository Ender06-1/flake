{ inputs, ... }:

{
  den.aspects.matheo.cli = {
    nixos = {
      services.tailscale.enable = true;
    };

    homeManager =
      { pkgs, ... }:
      let
        system = pkgs.stdenv.system;
        pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
      in
      {
        home.packages = with pkgs; [
          nix-inspect
          bat
          fastfetch
        ];

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

        programs.neovim = {
          enable = true;
          package = pkgs-unstable.neovim-unwrapped;

          defaultEditor = true;

          waylandSupport = true;

          viAlias = true;
          vimAlias = true;
          vimdiffAlias = true;
        };
        programs.yazi.enable = true;

        programs.zellij = {
          enable = true;
          settings = {
            theme = "onedark";
            show_startup_tips = false;
            pane_frame_style = "full";
          };
        };

        programs.zoxide.enable = true;
      };
  };
}
