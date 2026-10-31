{ den, ... }:

{
  den.aspects.matheo = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user

      den.aspects.hyprland-caelestia
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

        programs.kitty.enable = true;

        xdg = {
          enable = true;
          userDirs = {
            enable = true;
            createDirectories = true;
          };
        };

        home.packages = with pkgs; [
          neovim
          tree
          firefox
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
