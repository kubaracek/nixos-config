{ lib, config, options, ... }:

let
  inherit (builtins) getEnv currentSystem;
  inherit (lib) optional substring stringLength isFunction isString
    functionArgs pathExists readFile attrNames;
  inherit (lib.systems.elaborate { system = currentSystem; }) isLinux isDarwin;

  __nixPath = builtins.nixPath ++ [
    { prefix = "nixpkgs-overlays"; path = ./overlays; }

    {
      prefix = "home-manager";
      path =
        fetchTarball {
          url =
            let ref = "master"; in
            "https://github.com/rycee/home-manager/archive/${ref}.tar.gz";
        };
    }
  ];

  HOST = getEnv "HOST";
  hostname = if HOST != "" then HOST else
    (h: substring 0 (stringLength h - 1) h) (readFile (
      if !isDarwin then
        /etc/hostname
      else
        derivation {
          name = "hostname";
          system = currentSystem;
          builder = "/bin/sh";
          args = [ "-c" "/usr/sbin/scutil --get LocalHostName > $out" ];
        }
    ));

  inject = {
    inherit __nixPath hostname isLinux isDarwin;
    ft = lib;
  };

  moduleArgs = m: removeAttrs (functionArgs m) (__attrNames inject);
  pathFixup = path: if isString path then ./. + "/${path}" else path;
  wrapImports = imports: map (file: wrapModule (pathFixup file) (import (pathFixup file))) imports;

  wrapModuleImports = file: m: m // {
    _file = toString file;
    key = toString file;
    imports = wrapImports (m.imports or [] ++ m.require or []);
  };

  wrapModule = file: m: if ! isFunction m then wrapModuleImports file m else {
    __functor = self: { ... }@args: wrapModuleImports file (m (args // inject));
    __functionArgs = moduleArgs m;
  };

  optionalIfExists = file: optional (pathExists (pathFixup file)) (pathFixup file);
in
  wrapModule ./configuration.nix {
    nix.nixPath =
      options.nix.nixPath.default
      ++ map
        (
          { prefix ? "", path }@args:
            if args ? prefix then 
              "${prefix}=${toString path}"
            else
              toString path
        )
        __nixPath;

    imports =
      [
        ./modules
        ./profiles/common.nix
        "hosts/${hostname}.nix"
      ]
      ++ optionalIfExists ./hardware-configuration.nix
      ++ optionalIfExists "hosts/${hostname}-hardware.nix";

    networking.hostName = hostname;
  }
