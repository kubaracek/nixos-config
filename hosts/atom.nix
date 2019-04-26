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
    "profiles/x.nix"
  ];

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

  # Disable wifi when on wire
  networking.networkmanager.dispatcherScripts = [{
    type = "basic";

    source = pkgs.writeText "disable-wireless-when-wired" ''${ft.sh}
      IFACE=$1
      ACTION=$2
      nmcli=${pkgs.networkmanager}/bin/nmcli

      case ''${IFACE} in
          eth*|en*)
              case ''${ACTION} in
                  up)
                      logger "disabling wifi radio"
                      $nmcli radio wifi off
                      ;;
                  down)
                      logger "enabling wifi radio"
                      $nmcli radio wifi on
                      ;;
              esac
              ;;
      esac
    '';
  }];
}
