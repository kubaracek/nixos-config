{ config, pkgs, ... } :

{
  imports = [
    ../options/default.nix
    ../cfgs/htop.nix
    ../cfgs/neovim.nix
    ../cfgs/tmux.nix
    ../cfgs/zsh.nix
    ./hosts.nix
    ./users.nix
  ];

  services.gpm.enable = true;

  time.timeZone = "America/New_York";

  networking.firewall.enable = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    defaultLocale = "en_US.UTF-8";
    consoleUseXkbConfig = true;
  };

  services.xserver = {
    layout = "us";
    xkbOptions = "caps:scape,compose:prsc";
  };

  environment.systemPackages = with pkgs; [
    ack
    curl
    file
    mosh
    nmap
    pv
    telnet
    w3m
    wget
    whois
    youtube-dl
    nix-prefetch-git
    gnupg
    zip
    unzip

    git
    gitAndTools.git-hub
    gitAndTools.hub
    gitAndTools.git-fame
    (pkgs.callPackage ../pkgs/lab/default.nix { })
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "18.09";
}
