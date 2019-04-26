{ ... }:

{
  programs.git = {
    enable = true;
    userName = "kubaracek (Jakub Racek)";
    userEmail = "me@jakubracek.net";

    signing = {
      key = "6A8C950A89DC08286F750BFAFD071E22A924E1FD";
    };

    ignores = [
      "*.todo"
    ];

    extraConfig = {
    };
  };
}
