{ pkgs, ... }:

{
  home.packages = [
    pkgs.xmonad-log
  ];
  xsession.windowManager = {
    xmonad = {
      enable = true;
      extraPackages = hpkgs: [
        hpkgs.xmonad-contrib
        hpkgs.xmonad-extras
        hpkgs.dbus
      ];
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };
  };
  services.polybar = {
    enable = true;
    script = "polybar bar &";
    config = ./polybar.config;
  };
}
