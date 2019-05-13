{ pkgs, ... }:

{
  systemd.user.services.emacs-daemon = {
    Unit = {
      Description = "Emacs text editor";
      Documentation = "info:emacs man:emacs(1) https://gnu.org/software/emacs/";
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.stdenv.shell} -l -c 'exec /run/current-system/sw/bin/emacs --fg-daemon'";
      ExecStop = "/run/current-system/sw/bin/emacsclient --eval '(kill-emacs)'";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
