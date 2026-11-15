{ den, ... }:

{
  den.hosts.x86_64-linux.hp-server.users.admin = { };

  den.aspects.hp-server = {
    includes = with den.aspects; [
      agenix

      hp-server.caddy

      hp-server.services.filebrowser
      hp-server.services.vaultwarden
      hp-server.services.ntfy
      hp-server.services.immich
    ];

    nixos =
      {
        config,
        pkgs,
        modulesPath,
        lib,
        ...
      }:
      {
        imports = [
          ./_hardware-configuration.nix
        ];

        boot.initrd.luks.devices.cryptroot.device =
          "/dev/disk/by-uuid/8018bf33-36e3-48e1-9075-f825bfb57512";

        boot.supportedFilesystems = [ "zfs" ];
        boot.zfs = {
          forceImportRoot = false;
          extraPools = [ "tank" ];
        };

        environment.etc.crypttab.text = ''
          crypthdd1 UUID=16d1c857-0cd3-478e-9254-1a6b4ecafb40 /root/hdd1_keyfile.key
          crypthdd2 UUID=53ee822f-2ea6-48b1-a56a-6842b7ff746b /root/hdd2_keyfile.key
          crypthdd3 UUID=28eed261-09a6-4e71-82a8-f650e60e8348 /root/hdd3_keyfile.key
        '';

        services.zfs = {
          autoScrub.enable = true;
          zed.settings = {
            ZED_NOTIFY_VERBOSE = 1;
            ZED_NTFY_URL = "https://ntfy.tailb1bb3f.ts.net";
            ZED_NTFY_TOPIC = "storage";
          };
        };

        services.smartd = {
          enable = true;
          autodetect = true;

          notifications = {
            mail = {
              enable = true;
              mailer = "${pkgs.writeShellScript "smartd-ntfy" ''
                ${pkgs.curl}/bin/curl  \
                  -H "Title: SMARTD: ''${SMARTD_SUBJECT}" \
                  -d "''${SMARTD_FAILTYPE} Device: ''${SMARTD_DEVICE} Time: ''${SMARTD_TFIRST} Message: ''${SMARTD_FULLMESSAGE}" \
                  https://ntfy.tailb1bb3f.ts.net/hdd-pool
              ''}";
            };

            wall.enable = false;
            x11.enable = false;
          };
        };

        services.sanoid = {
          enable = true;
          templates."production" = {
            hourly = 24;
            daily = 15;
            monthly = 4;
            yearly = 2;

            autosnap = true;
            autoprune = true;

            pre_snapshot_script = "${pkgs.writeShellScript "sanoid-pre-snapshot-ntfy.sh" ''
              ${pkgs.curl}/bin/curl \
                -H "Title: ZFS snapshot starting for ''${SANOID_TARGETS}" \
                -H "Priority: default" \
                -H "Tags: hourglass,floppy_disk" \
                -d "Dataset: ''${SANOID_TARGETS}
                    Snapshot name: ''${SANOID_SNAPNAMES}
                    Snapshot type: ''${SANOID_TYPES}" \
                https://ntfy.tailb1bb3f.ts.net/hdd-pool
            ''}";
            post_snapshot_script = "${pkgs.writeShellScript "sanoid-post-snapshot-ntfy.sh" ''
              ${pkgs.curl}/bin/curl \
                -H "Title: ZFS snapshot completed for ''${SANOID_TARGETS}" \
                -H "Priority: default" \
                -H "Tags: white_check_mark,floppy_disk" \
                -d "Dataset: ''${SANOID_TARGETS}
                    Snapshot name: ''${SANOID_SNAPNAMES}
                    Snapshot type: ''${SANOID_TYPES}" \
                https://ntfy.tailb1bb3f.ts.net/hdd-pool

            ''}";
          };
          datasets = {
            "tank/filebrowser".use_template = [ "production" ];
            "tank/immich".use_template = [ "production" ];
            "tank/old_data".use_template = [ "production" ];
            "tank/vaultwarden".use_template = [ "production" ];
          };
        };

        boot.loader = {
          limine = {
            enable = true;
            secureBoot.enable = true;
            maxGenerations = 20;
          };
          efi.canTouchEfiVariables = true;
        };

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
        nixpkgs.config.allowUnfree = true;

        time.timeZone = "Europe/Paris";
        i18n.defaultLocale = "en_US.UTF-8";
        i18n.extraLocales = [ "fr_FR.UTF-8/UTF-8" ];

        networking.hostId = "4ae6ae4e";
        networking.hostName = "hp-server";
        networking.networkmanager.enable = true;

        console.keyMap = "us";

        services.openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
          };
        };

        services.tailscale.enable = true;

        virtualisation.docker.enable = true;
      };
  };
}
