{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShellNoCC {
      name = "flake";

      packages = with pkgs; [
        nixfmt-tree
      ];
    };
  };
}
