{ den, ... }:

{
  den.aspects.matheo = {
    includes = with den.aspects.matheo; [
      den.batteries.define-user
      den.batteries.primary-user

      shell
      cli
      hyprland
      desktop-apps
    ];

    nixos = {
      users.users.matheo.initialPassword = "matheo";
    };

    homeManager =
      { pkgs, ... }:
      {
        xdg = {
          enable = true;
          userDirs = {
            enable = true;
            createDirectories = true;
          };
        };
      };
  };
}
