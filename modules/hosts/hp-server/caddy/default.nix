{
  den.aspects.hp-server.caddy.nixos =
    { config, pkgs, ... }:
    {
      age.secrets.caddy.file = ./_secrets/caddy.age;

      services.caddy = {
        enable = true;

        package = pkgs.caddy.withPlugins {
          plugins = [ "github.com/tailscale/caddy-tailscale@v0.0.0-20260826180304-de41b249af4f" ];
          hash = "sha256-I9A+/rwj97qu2yAP3rm+4+QBJjOKzngMM14nWZ3r6Q4=";
        };

        environmentFile = config.age.secrets.caddy.path;
      };
    };
}
