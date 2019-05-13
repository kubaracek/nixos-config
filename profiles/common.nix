{ config, lib, pkgs, __nixPath, ft, ... }:

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
          nix-prefetch-git
          vim
          rofi
          taffybar
          xorg.xbacklight
          feh
          gcc
          emacs
      ];

      sound.enable = true;
      hardware.pulseaudio.enable = true;
      
      hardware.brightnessctl.enable = true;

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
      # Swap caps for ctrl
      services.xserver.xkbOptions = "ctrl:nocaps";

      system.stateVersion = "19.03";
      fonts.fonts = with pkgs ; [
        dina-font
        siji
        unifont
      ];
  }
