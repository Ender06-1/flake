{ den, ... }:

{
  den.aspects.matheo = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "fish")

      den.aspects.hyprland-caelestia
      den.aspects.kitty
      den.aspects.fish
      den.aspects.eza
      den.aspects.flatpak
      den.aspects.zoxide
      den.aspects.zellij
      den.aspects.neovim
      den.aspects.firefox
      den.aspects.yazi
    ];

    homeManager =
      { pkgs, ... }:
      {

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

        xdg = {
          enable = true;
          userDirs = {
            enable = true;
            createDirectories = true;
          };
        };

        home.packages = with pkgs; [
          nix-inspect
          bat
          fastfetch

          prismlauncher
          javaPackages.compiler.openjdk25
        ];
      };

    provides.to-hosts.nixos = {
      users.users.matheo.initialPassword = "matheo";

      services.displayManager.ly = {
        enable = true;
        x11Support = false;
      };

      services.tailscale.enable = true;
    };
  };
}
