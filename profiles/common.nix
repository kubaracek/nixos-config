{ config, lib, pkgs, __nixPath, ... }:

let
  inherit (lib) optional optionals optionalAttrs;
in
  {
    imports =
      [
        "config/htop.nix"
        "profiles/hosts.nix"
        "profiles/users.nix"
      ];

      # The default stuff
      environment.systemPackages = with pkgs; [
          ag
          curl
          file
          wget
          git
          whois
          speedtest-cli
      ];

      # Yaay
      nixpkgs.config.allowUnfree = true;

      services.gpm.enable = true;

      time.timeZone = "Europe/Prague";

      networking.firewall.enable = true;

      i18n = {
        defaultLocale = "en_US.UTF-8";
        consoleUseXkbConfig = true;
      };

      services.xserver = {
        layout = "us";
      };

      system.stateVersion = "19.03";
  }
