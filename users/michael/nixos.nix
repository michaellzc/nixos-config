{ pkgs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  users.users.michael = {
    isNormalUser = true;
    home = "/home/michael";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    initialPassword = "password";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEAz0NIBAuVDcTAZMrgLXd6P6Kfuk8t6+CeFBkvAIlLr hi@michaellin.me"
    ];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix)
  ];
}
