self: super:

let
  inherit (builtins) mapAttrs readDir;
  inherit (super) callPackage;
  inherit (super.lib) optionalAttrs;
  inherit (super.stdenv) isLinux isDarwin;

  callPackages = path: ignore:
    mapAttrs
      (name: value: callPackage (path + "/${name}") { })
      (removeAttrs (readDir path) ignore);
in
  callPackages ./. [ "default.nix" ]
