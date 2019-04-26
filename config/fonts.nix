{ lib, pkgs, ... }:

let
  inherit (lib) optional optionalAttrs;
in
  {
    fonts =
      {
        fonts =
          with pkgs; [
            fira
            fira-mono
            fira-code
            emojione
          ]
      }

    enableFontDir = true;
  }
