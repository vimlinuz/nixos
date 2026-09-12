{ pkgs, inputs, ... }:
let
  vague-gtk-theme = pkgs.stdenvNoCC.mkDerivation {
    pname = "vague-gtk-theme";
    version = "unstable-2026-08-07";
    src = inputs.vague-gtk;
    installPhase = ''
      mkdir -p $out/share/themes
      cp -r Vague $out/share/themes/
    '';
  };

  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };

  font = {
    name = "JetBrainsMono Nerd Font";
    size = 8;
  };

  theme = {
    name = "Vague";
    package = vague-gtk-theme;
  };

in
{
  gtk = {
    enable = true;
    colorScheme = "dark";
    inherit iconTheme;
    inherit font;
    inherit theme;

    gtk2 = {
      enable = true;
      inherit font;
      inherit iconTheme;
    };

    gtk3 = {
      enable = true;
      inherit font;
      inherit iconTheme;
    };

    gtk4 = {
      inherit theme;
      inherit iconTheme;
      inherit font;
    };

  };
}
