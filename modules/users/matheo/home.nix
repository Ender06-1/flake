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

  home.packages = with pkgs; [
    neovim
    tmux
    tree
  ];

  home.stateVersion = "26.05";

}

