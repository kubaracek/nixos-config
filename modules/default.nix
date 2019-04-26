{ lib, ... }:

let
  inherit (lib) optionals;
  inherit (builtins) attrNames readDir;

  readPath = path: ignore:
    map
      (name: path + "/${name}")
      (attrNames (removeAttrs (readDir path) ignore));
in
  {
    imports =
      readPath ./. [ "default.nix" ]
  }
