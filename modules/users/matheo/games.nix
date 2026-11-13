{
  den.aspects.matheo.games = {
    nixos = {
      programs.steam.enable = true;

      services.flatpak.enable = true;
    };

    homeManager = { pkgs, ... }: {
      programs.prismlauncher.enable = true;

      # home.packages = with pkgs; [
      #   javaPackages.compiler.openjdk25
      # ];
    };
  };
}
