{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.callPackage ../pkgs/lutris/default.nix {
      dumb = (pkgs.callPackage ../pkgs/dumb/default.nix { });
      sndio = (pkgs.callPackage ../pkgs/sndio/default.nix { });
    })
  ];
}
