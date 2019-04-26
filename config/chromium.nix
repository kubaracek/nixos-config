{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
  ];

  nixpkgs.config.chromium = {
    pulseSupport = true;
  };

  environment.variables = {
    BROWSER = pkgs.lib.mkOverride 0 "chromium";
  };

  networking.firewall.allowedUDPPortRanges = [
    { from = 32768; to = 61000; }
  ];

  networking.firewall.allowedTCPPortRanges = [
    { from = 8008; to = 8009; }
  ];

  networking.firewall.allowedUDPPorts = [
    1900
  ];

  programs.chromium = {
    enable = true;

    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin - https://github.com/gorhill/uBlock
      "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere - https://github.com/EFForg/https-everywhere
      "klbibkeccnjlkjkiokjodocebajanakg" # The Great Suspender - https://github.com/deanoemcke/thegreatsuspender
      "dhdgffkkebhmkfjojejmpbldmpobfkfo" # Tampermonkey - https://github.com/Tampermonkey/tampermonkey
      "einpaelgookohagofgnnkcfjbkkgepnp" # Random User-Agent - https://github.com/tarampampam/random-user-agent
    ];

    extraOpts = {
      EnableMediaRouter = true;
      #ShowCastIconInToolbar = true;
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    chromium =
      (pkgs.chromium.override {
        # load-media-router-component-extension is required for Chromecast/Google Cast
        commandLineArgs = builtins.replaceStrings [ "\n" ] [ " " ] ''
          --load-media-router-component-extension=1
          --ignore-gpu-blacklist=1
          --enable-features=ViewsCastDialog
        '';
      })
      .overrideAttrs (oldAttrs: rec {
        buildInputs = with pkgs; oldAttrs.buildInputs ++ [
          #plasma-browser-integration
        ];
      });
  };
}
