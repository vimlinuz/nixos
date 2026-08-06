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
in
{
  gtk = {
    enable = true;

    colorScheme = "dark";

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 8;
    };

    theme = {
      name = "Vague";
      package = vague-gtk-theme;
    };

    gtk2 = {
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

    };

    gtk4 = {
      theme = {
        name = "Vague";
        package = vague-gtk-theme;
      };
    };

  };
}
