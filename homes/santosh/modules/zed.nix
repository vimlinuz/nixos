{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "rust"
      "javascript"
    ];
    userSettings = {
      features = {
        copilot = false;
      };
      vim_mode = true;
      ui_font_family = "JetBrainsMono Nerd Font";
      buffer_font_family = "JetBrainsMono Nerd Font";
    };
  };
}
