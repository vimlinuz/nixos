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
      fg = "#cdcdcd";
      # bg = "#141415";
      hl = "#f3be7c";
      "fg+" = "#aeaed1";
      # "bg+" = "#252530";
      "hl+" = "#f3be7c";
      border = "#606079";
      header = "#6e94b2";
      gutter = "#141415";
      spinner = "#7fa563";
      info = "#f3be7c";
      pointer = "#aeaed1";
      marker = "#d8647e";
      prompt = "#bb9dbd";
    };
    defaultOptions = [
      "--reverse"
    ];
  };
}
