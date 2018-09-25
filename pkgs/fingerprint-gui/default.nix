{ stdenv, qt5, libsForQt5, libfakekey, libfprint, libusb, pam, xorg }:

stdenv.mkDerivation rec {
  version = "1.09";
  name = "fingerprint-gui-${version}";

  src = builtins.fetchTarball {
    url = "https://github.com/maksbotan/fingerprint-gui/archive/v${version}-qt5.tar.gz";
    sha256 = "1pqvm2vzn3riwx8gmhq8ayza0i35pxcy70yz5n0019cjajzy8z4p";
  };

  buildInputs = with libsForQt5; with qt5; [
    libfakekey
    libfprint
    polkit-qt
    qca-qt5
    qtx11extras
    libusb
    pam
    xorg.libXtst
  ];

  nativeBuildInputs = [ qt5.qmake ];

  qmakeFlags = [
    #"PREFIX=$out"
    #"INSTALL_PREFIX=$out"
    #"INSTALLROOT=$(out)"
    "PREFIX=/"
  ];

  installFlags = [ "INSTALL_ROOT=$(out)" ];

  meta = with stdenv.lib; {
    description = "An application providing fingerprint-based authentication on Linux desktops.";

    homepage = https://github.com/maksbotan/fingerprint-gui;
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
