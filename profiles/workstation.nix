{ config, pkgs, ... }:

{
  imports = [
    "config/chromium.nix"
    "config/keybase.nix"
    "config/networkmanager.nix"
  ];

  environment.systemPackages = with pkgs; [
    kubectl
  ];
}
