{ config, pkgs, lib, ... }:

{
  imports = [
    "config/docker.nix"
    "config/networkmanager.nix"
    "hardware-configuration.nix"
    "profiles/common.nix"
    "profiles/thinkpad.nix"
    "profiles/workstation.nix"
    "profiles/music.nix"
    "profiles/movies.nix"
    "profiles/x.nix"
  ];

  # Bootloader
  boot.loader = {
    grub.enable = true;
    grub.version = 2;
    grub.device = "/dev/sda";
  };

  networking.firewall.allowedTCPPortRanges = [
    { from = 4100; to = 4105; }
  ];

  networking.firewall.allowedUDPPorts = [
    5353
  ];

  networking.firewall.allowedTCPPorts = [
    3000
    4000
    5000
    9001
    1337
  ];


  # Extra packages
  environment.systemPackages = with pkgs; [
  ];

  # Enable ssh, disable password
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };
}
