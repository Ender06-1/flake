{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "flake";

      packages = with pkgs; [
        nixfmt-tree
      ];
    };
  };
}
