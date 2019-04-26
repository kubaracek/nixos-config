{ config, pkgs, ... }:

{
  imports = [
    "config/gnome.nix"
  ];

  services.xserver = {
    enalbe = true;
    default = "gnome3";
  };
}
