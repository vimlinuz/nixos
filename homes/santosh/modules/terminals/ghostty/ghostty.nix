{ pkgs, config, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";

      # command = "${pkgs.nushell}/bin/nu";

      font-family = "JetBrainsMono Nerd Font";
      font-family-bold = "JetBrainsMono Nerd Font";
      font-family-italic = "JetBrainsMono Nerd Font";
      font-family-bold-italic = "JetBrainsMono Nerd Font";
      custom-shader-animation = true;
      custom-shader = [
        "${config.home.homeDirectory}/nixos/homes/santosh/modules/terminals/ghostty/shaders/coil.glsl"
        "${config.home.homeDirectory}/nixos/homes/santosh/modules/terminals/ghostty/shaders/glow.glsl"
      ];
      mouse-hide-while-typing = true;
      cursor-style = "block";
      cursor-style-blink = false;
      # adjust-cursor-height = "-25%";

      # prevents the terminal from asking for confirmation when closing a surface with active processes
      confirm-close-surface = false;

      # disables both keyboard copy and config reload notifications
      app-notifications = false;
    };
    themes = {
      dark-funeral = import ./themes/dark-funeral.nix;
      catppuccin-mocha = import ./themes/catppuccin-mocha.nix;
      vague = import ./themes/vague.nix;
    };
  };
}
