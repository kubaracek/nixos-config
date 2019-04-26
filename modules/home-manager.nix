{ lib, ... }:

let
  inherit (lib) optional;
in
  {
    imports = <home-manager/nixos>;

    home-manager.useUserPackages = true;
  }
