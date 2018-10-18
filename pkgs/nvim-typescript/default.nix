{ fetchFromGitHub, callPackage, vimUtils, nodejs-10_x }:

let
  inherit (vimUtils) buildVimPluginFrom2Nix;
  nodeSources = import ./node-sources.nix;
in
  buildVimPluginFrom2Nix rec {
    pname = "nvim-typescript";
    version = "2018-10-09";

    name = "${pname}-${version}";

    src = fetchFromGitHub {
      owner = "mhartington";
      repo = pname;
      rev = "e27dbf31a298ac8ac2ab2ca808a12bb86b0fb97f";
      sha256 = "0l8csdnfl6d2ffg100rxy3n7f881wf4xszljdk565mszd0xx1yn6";
    };

    buildInputs = [ nodejs-10_x ];

    buildCommand = ''
      env
      cd $out/share/vim-plugins/nvim-typescript
      NO_UPDATE_NOTIFIER=true HOME=. ./install.sh
    '';
  }
