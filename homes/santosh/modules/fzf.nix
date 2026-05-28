{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [
      "--preview 'tree -C {} | head -200'"
    ];
    colors = {
      pointer = "#ffffff";
      marker = "#000000";
    };
  };
}
