{ config, pkgs, ... }:

{
  imports = [
    "config/gnome.nix"
  ];

  services.xserver = {
    enable = true;
    desktopManager.default = "gnome3";
  };
}
