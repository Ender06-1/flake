{ den, ... }:

{
  den.homes.x86_64-linux.matheo = { };

  den.aspects.matheo = {
    includes = with den.aspects; [
      den.batteries.define-user
      den.batteries.primary-user

      nixvim
      fish
      starship
      bat
      btop
      eza
      fastfetch
      fzf
      lazygit
      ssh
      yazi
      zellij
      zoxide

      matheo.direnv
      matheo.git
      matheo.nh
      matheo.podman

      matheo.games
      matheo.kitty
      matheo.firefox

      matheo.hyprland
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
