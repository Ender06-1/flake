{ den, ... }:

let
  serviceName = "vaultwarden";
  domain = "${serviceName}.tailb1bb3f.ts.net";
  port = "8001";
in
{
  den.hosts.x86_64-linux.hp-server.users.vaultwarden = { };

  den.aspects.vaultwarden = {
    includes = with den.aspects; [
      hp-server.service-user

      hp-server.services.vaultwarden
    ];

    user = {
      group = "filebrowser";
      extraGroups = [ "systemd-journal" ];
      linger = true;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHDADlY+ZzZfwKpa0aeuYJE9MT6bvLGiBchDpBe+olt1"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILZySQNthwFjyswLFStt0KXDtBqX+qLyyianZhtzMqt2"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE21MuE2hoyGNoZoPMuGc1zyWPcpOHVO91Mo9zQoq6ew"
      ];
    };
  };

  den.aspects.hp-server.services.vaultwarden = {
    nixos = {
      users.groups.vaultwarden = { };

      services.caddy.virtualHosts.${domain}.extraConfig = ''
        bind tailscale/${serviceName}
        tailscale_auth
        reverse_proxy 127.0.0.1:${port}
      '';
    };

    homeManager = {
      services.podman = {
        enable = true;
        containers.vaultwarden = {
          image = "vaultwarden/server:latest";
          autoStart = true;
          userNS = "keep-id:uid=1000,gid=1000";
          environment = {
            DOMAIN = "https://vaultwarden.tailb1bb3f.ts.net";
            ROCKET_PORT = 8000;
          };
          ports = [ "127.0.0.1:${port}:8000" ];
          volumes = [
            "/srv/tank/vaultwarden/:/data/"
          ];
        };
      };
    };
  };
}
