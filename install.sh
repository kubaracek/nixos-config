#!/bin/sh
export HOST

: ${INSTALL_PATH=/etc/nixos}

if [[ -d $INSTALL_PATH ]]; then
  mv $INSTALL_PATH $INSTALL_PATH-orig
  : ${SOURCE_PATH=$INSTALL_PATH-orig/configuration.nix}
  cp $INSTALL_PATH-orig/hardware-configuration.nix $INSTALL_PATH
fi

git git@github.com:kubaracek/nixos-config.git $INSTALL_PATH
cd $INSTALL_PATH

if [[ ! -e ./hosts/$HOST.nix ]]; then
  cp $SOURCE_PATH ./hosts/$HOST.nix
fi
