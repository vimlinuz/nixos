{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = false;
    enableNushellIntegration = false;

    flags = [ "--disable-up-arrow" ];

    settings = {
      invert = true;
      show_help = false;
      style = "full";

      enter_accept = true;
      keymap_mode = "vim-insert";
    };
  };
}
