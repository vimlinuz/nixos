{
  programs.zathura = {
    enable = true;
    options = {
      # copy selections to the system clipboard
      selection-clipboard = "clipboard";
      window-title-basename = "true";

      # Soft warm dark theme for long reading sessions
      notification-error-bg = "rgba(193,80,78,1)";      # Soft red
      notification-error-fg = "rgba(232,226,212,1)";    # Foreground
      notification-warning-bg = "rgba(212,166,83,1)";   # Soft orange
      notification-warning-fg = "rgba(43,40,35,1)";     # Background
      notification-bg = "rgba(43,40,35,1)";             # Background
      notification-fg = "rgba(207,198,180,1)";          # Foreground

      completion-bg = "rgba(43,40,35,1)";               # Background
      completion-fg = "rgba(124,116,102,1)";            # Muted
      completion-group-bg = "rgba(43,40,35,1)";         # Background
      completion-group-fg = "rgba(124,116,102,1)";      # Muted
      completion-highlight-bg = "rgba(58,54,46,1)";     # Selection
      completion-highlight-fg = "rgba(232,226,212,1)";  # Foreground

      index-bg = "rgba(43,40,35,1)";                    # Background
      index-fg = "rgba(207,198,180,1)";                 # Foreground
      index-active-bg = "rgba(58,54,46,1)";             # Current Line
      index-active-fg = "rgba(232,226,212,1)";          # Foreground

      inputbar-bg = "rgba(43,40,35,1)";                 # Background
      inputbar-fg = "rgba(207,198,180,1)";              # Foreground
      statusbar-bg = "rgba(43,40,35,1)";                # Background
      statusbar-fg = "rgba(207,198,180,1)";             # Foreground

      highlight-color = "rgba(212,154,84,0.45)";        # Soft orange
      highlight-active-color = "rgba(188,122,140,0.45)"; # Soft rose

      default-bg = "rgba(35,32,28,1)";                  # Background
      default-fg = "rgba(207,198,180,1)";               # Foreground

      render-loading = true;
      render-loading-fg = "rgba(43,40,35,1)";           # Background
      render-loading-bg = "rgba(207,198,180,1)";        # Foreground

      # Recolor mode settings
      recolor-lightcolor = "rgba(46,42,36,1)";          # Warm page background
      recolor-darkcolor = "rgba(200,191,169,1)";        # Warm page text

      # Startup options
      adjust-open = "width";
      recolor = true;
    };
  };
}
