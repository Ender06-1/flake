{ den, ... }:

{
  den.aspects.admin = {
    includes = with den.aspects; [
      den.batteries.define-user
      den.batteries.primary-user

      nixvim
    ];

    user.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHDADlY+ZzZfwKpa0aeuYJE9MT6bvLGiBchDpBe+olt1"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILZySQNthwFjyswLFStt0KXDtBqX+qLyyianZhtzMqt2"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE21MuE2hoyGNoZoPMuGc1zyWPcpOHVO91Mo9zQoq6ew"
    ];
  };
}
