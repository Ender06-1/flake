let
  serviceName = "filebrowser";
  domain = "${serviceName}.tailb1bb3f.ts.net";
  port = "8000";
in
{
  den.aspects.hp-server.services.${serviceName}.nixos = {
    imports = [
      ./_compose.nix
    ];

    services.caddy.virtualHosts.${domain}.extraConfig = ''
      bind tailscale/${serviceName}
      tailscale_auth
      reverse_proxy 127.0.0.1:${port}
    '';

    systemd.tmpfiles.rules = [
      "d /var/stacks/${serviceName} 0700 admin users -"
    ];
  };
}
