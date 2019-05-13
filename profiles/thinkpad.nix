{ config, lib, pkgs, ... }:

{
  powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.powertop.enable = true;

  hardware.opengl = {
    extraPackages = [ pkgs.vaapiIntel ];
    s3tcSupport = true;
  };

  services.xserver = {
    videoDrivers = [ "modesetting" ];
    useGlamor = true;
    
    synaptics.enable = false;

    libinput = {
      enable = true;
      naturalScrolling = true;
    };
  };
}
