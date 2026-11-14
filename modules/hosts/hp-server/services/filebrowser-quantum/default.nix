{ den, ... }:

let
  serviceName = "filebrowser";
  domain = "${serviceName}.tailb1bb3f.ts.net";
in
{
  den.hosts.x86_64-linux.hp-server.users.filebrowser = { };

  den.aspects.filebrowser = {
    includes = with den.aspects; [
      service-user

      hp-server.filebrowserQuantum
    ];

    user = {
      group = "filebrowser";
      linger = true;
      isNormalUser = true;
    };
  };

  den.aspects.hp-server.filebrowserQuantum = {
    nixos = {
      users.groups.filebrowser = { };

      services.caddy.virtualHosts.${domain}.extraConfig = ''
        bind tailscale/${serviceName}
        tailscale_auth
        reverse_proxy 127.0.0.1:8000
      '';
    };

    homeManager = {
      services.podman = {
        enable = true;
        containers.filebrowser = {
          image = "ghcr.io/gtsteffaniak/filebrowser:2.0-stable";
          autoStart = true;
          userNS = "keep-id:uid=1000,gid=1000";
          ports = [ "127.0.0.1:8000:8000" ];
          volumes = [
            "/srv/tank/filebrowser/data:/home/filebrowser/data"
            "/srv/tank/filebrowser/files:/mnt/storage"
          ];
        };
      };
    };
  };
}
