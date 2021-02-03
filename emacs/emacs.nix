{ config, lib, pkgs, ... }:

{
  # https://github.com/nix-community/emacs-overlay
  # TODO: Make this a channel?
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    /* package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./init.el;
      alwaysEnsure = true;
    }; */
  };

  # Packages used by use-package of init.el
  home.packages = with pkgs; [
    ormolu
    cmake
  ];

  # services.emacs.enable = true;
}
