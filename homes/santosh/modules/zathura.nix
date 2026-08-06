{
  programs.zathura = {
    enable = true;
    options = {
      # copy selections to the system clipboard
      selection-clipboard = "clipboard";
      window-title-basename = "true";

      # Vague colorscheme: https://github.com/vague-theme/vague.nvim
      notification-error-bg = "rgba(216,100,126,1)"; # error
      notification-error-fg = "rgba(205,205,205,1)"; # fg
      notification-warning-bg = "rgba(243,190,124,1)"; # warning
      notification-warning-fg = "rgba(20,20,21,1)"; # bg
      notification-bg = "rgba(20,20,21,1)"; # bg
      notification-fg = "rgba(205,205,205,1)"; # fg

      completion-bg = "rgba(20,20,21,1)"; # bg
      completion-fg = "rgba(96,96,121,1)"; # comment
      completion-group-bg = "rgba(20,20,21,1)"; # bg
      completion-group-fg = "rgba(96,96,121,1)"; # comment
      completion-highlight-bg = "rgba(37,37,48,1)"; # line
      completion-highlight-fg = "rgba(205,205,205,1)"; # fg

      index-bg = "rgba(20,20,21,1)"; # bg
      index-fg = "rgba(205,205,205,1)"; # fg
      index-active-bg = "rgba(37,37,48,1)"; # line
      index-active-fg = "rgba(205,205,205,1)"; # fg

      inputbar-bg = "rgba(20,20,21,1)"; # bg
      inputbar-fg = "rgba(205,205,205,1)"; # fg
      statusbar-bg = "rgba(20,20,21,1)"; # bg
      statusbar-fg = "rgba(205,205,205,1)"; # fg

      highlight-color = "rgba(64,80,101,0.45)"; # search
      highlight-active-color = "rgba(174,174,209,0.45)"; # constant

      default-bg = "rgba(20,20,21,1)"; # bg
      default-fg = "rgba(205,205,205,1)"; # fg

      render-loading = true;
      render-loading-fg = "rgba(20,20,21,1)"; # bg
      render-loading-bg = "rgba(205,205,205,1)"; # fg

      # Recolor mode settings
      recolor-lightcolor = "rgba(20,20,21,1)"; # bg
      recolor-darkcolor = "rgba(205,205,205,1)"; # fg

      # Startup options
      adjust-open = "width";
      recolor = true;
    };
  };
}
