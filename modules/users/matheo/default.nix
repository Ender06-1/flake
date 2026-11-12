{ den, ... }:

{
  den.aspects.matheo = {
    includes = with den.aspects; [
      den.batteries.define-user
      den.batteries.primary-user

      nixvim

      matheo.hyprland
      matheo.cli
      matheo.desktop-apps
    ];

    homeManager.xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
  };
}
