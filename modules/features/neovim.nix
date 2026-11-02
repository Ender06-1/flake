{ inputs, ... }:

{
  den.aspects.neovim.homeManager =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.system;
      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
    in
    {
      programs.neovim = {
        enable = true;
        package = pkgs-unstable.neovim-unwrapped;

        defaultEditor = true;

        waylandSupport = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
      };
    };
}
