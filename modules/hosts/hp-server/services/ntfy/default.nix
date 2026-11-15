let
  serviceName = "ntfy";
  domain = "${serviceName}.tailb1bb3f.ts.net";
in
{
  den.aspects.hp-server.services.${serviceName}.nixos = {
    imports = [
      ./_compose.nix
    ];

    services.caddy.virtualHosts.${domain}.extraConfig = ''
      bind tailscale/${serviceName}
      tailscale_auth
      reverse_proxy 127.0.0.1:8002
    '';

    systemd.tmpfiles.rules = [
      "d /var/stacks/ntfy/cache 0700 admin users -"
    ];
  };
}
