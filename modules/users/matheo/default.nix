{ den, ... }:

{
  den.aspects.matheo = {
    includes = with den.aspects; [
      den.batteries.define-user
      den.batteries.primary-user

      nixvim

      matheo.bat
      matheo.btop
      matheo.direnv
      matheo.eza
      matheo.fastfetch
      matheo.fish
      matheo.fzf
      matheo.git
      matheo.lazygit
      matheo.nh
      matheo.podman
      matheo.ssh
      matheo.starship
      matheo.yazi
      matheo.zellij
      matheo.zoxide

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
