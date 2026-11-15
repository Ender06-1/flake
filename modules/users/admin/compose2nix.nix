{
  den.aspects.admin.compose2nix.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [ compose2nix ];
  };
}
