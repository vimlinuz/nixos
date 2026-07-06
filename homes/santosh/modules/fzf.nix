{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;

    # disabled history mapping for bash
    historyWidget.bash.command = "";
    changeDirWidget.command = "fd --type d";
    changeDirWidget.options = [
      "--preview 'tree -C {} | head -200'"
    ];
    colors = {
      pointer = "#ffffff";

      marker = "#000000";
    };
    defaultOptions = [
      "--reverse"
    ];
  };
}
