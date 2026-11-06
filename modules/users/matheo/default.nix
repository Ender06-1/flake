{ den, ... }:

{
  den.aspects.matheo = {
    includes = with den.aspects.matheo; [
      den.batteries.define-user
      den.batteries.primary-user

      hyprland
      cli
      desktop-apps
      editor
    ];

    nixos = {
      nixpkgs.config.allowUnfree = true;

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
