{ config, pkgs, lib, ft, ... }:

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
  

  services.xserver = {
    enable = true;
    windowManager = {
      xmonad.enable = true;
      default = "xmonad";
    };
    desktopManager = {
      xterm.enable = false;
      default = "none";
    };
  };

  # Extra packages
  environment.systemPackages = with pkgs; [
  ];

  # Enable ssh, disable password
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };
}
