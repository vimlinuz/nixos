{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = {
      invert = true;
      show_help = false;
      style = "full";

      enter_accept = true;
      keymap_mode = "vim-insert";
    };
  };
}
