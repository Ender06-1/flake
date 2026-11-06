{
  den.aspects.matheo.desktop-apps = {
    nixos = {
      programs.steam.enable = true;

      services.flatpak.enable = true;
    };

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        prismlauncher
        javaPackages.compiler.openjdk25
      ];

      programs.firefox.enable = true;

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
  };
}
