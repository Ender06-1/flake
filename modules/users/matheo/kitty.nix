{
  den.aspects.matheo.kitty.homeManager = { pkgs, ... }: {
    programs.kitty = {
      enable = true;
      font = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Reg";
      };
      themeFile = "OneDark-Pro";
      settings = {
        shell = "fish";
        remember_window_size = "no";
      };
    };
  };
}
