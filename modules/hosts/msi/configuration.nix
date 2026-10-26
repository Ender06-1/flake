{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.limine = {
    enable = true;
    secureBoot.enable = true;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/77a5e5f4-0dbb-4c42-bd06-6d70eda481c4";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "msi";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  users.users.matheo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    sbctl
  ];

  system.stateVersion = "26.05";

}

