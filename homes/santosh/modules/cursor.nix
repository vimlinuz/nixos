{ pkgs, ... }:
{
  # home.pointerCursor = {
  #   gtk.enable = true;
  #   x11.enable = true;
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Original-Ice";
  #   size = 20;
  # };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.nightdiamond-cursors;
    name = "NightDiamond-Fusion";
    size = 20;
  };

  # home.pointerCursor = {
  #   gtk.enable = true;
  #   x11.enable = true;
  #   package = pkgs.callPackage ./nightdiamond-cursors.nix { };
  #   name = "NightDiamond-Fusion";
  #   size = 20;
  # };
}
