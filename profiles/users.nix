{ pkgs, ... }:

let
  authorizedKeys = import ./authorized-keys.nix;
in
  {
    users.defaultUserShell = pkgs.zsh;

    users.users.root.openssh.authorizedKeys.keys = authorizedKeys;

    home-manager.users.root = { ... }: {
      imports = [
        ../config/home/git.nix
      ];
    };

    users.extraUsers.jakub = {
      description = "Jakub Racek <me@jakubracek.net>";
      isNormalUser = true;
      uid = 1000;
      group = "users";
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
      ];
      createHome = true;
      initialPassword = "rootroot";
      useDefaultShell = true;
      openssh.authorizedKeys.keys = authorizedKeys;
    };

    home-manager.users.jakub = { ... }: {
      imports = [
        ../config/home/git.nix
      ];
    };
  }

