{
  programs.zathura = {
    enable = true;
    options = {
      # copy selections to the system clipboard
      selection-clipboard = "clipboard";
      window-title-basename = "true";

      # Dracula color theme
      notification-error-bg = "rgba(255,85,85,1)";      # Red
      notification-error-fg = "rgba(248,248,242,1)";    # Foreground
      notification-warning-bg = "rgba(255,184,108,1)";  # Orange
      notification-warning-fg = "rgba(68,71,90,1)";     # Selection
      notification-bg = "rgba(40,42,54,1)";             # Background
      notification-fg = "rgba(248,248,242,1)";          # Foreground

      completion-bg = "rgba(40,42,54,1)";               # Background
      completion-fg = "rgba(98,114,164,1)";             # Comment
      completion-group-bg = "rgba(40,42,54,1)";         # Background
      completion-group-fg = "rgba(98,114,164,1)";       # Comment
      completion-highlight-bg = "rgba(68,71,90,1)";     # Selection
      completion-highlight-fg = "rgba(248,248,242,1)";  # Foreground

      index-bg = "rgba(40,42,54,1)";                    # Background
      index-fg = "rgba(248,248,242,1)";                 # Foreground
      index-active-bg = "rgba(68,71,90,1)";             # Current Line
      index-active-fg = "rgba(248,248,242,1)";          # Foreground

      inputbar-bg = "rgba(40,42,54,1)";                 # Background
      inputbar-fg = "rgba(248,248,242,1)";              # Foreground
      statusbar-bg = "rgba(40,42,54,1)";                # Background
      statusbar-fg = "rgba(248,248,242,1)";             # Foreground

      highlight-color = "rgba(255,184,108,0.5)";        # Orange
      highlight-active-color = "rgba(255,121,198,0.5)"; # Pink

      default-bg = "rgba(40,42,54,1)";                  # Background
      default-fg = "rgba(248,248,242,1)";               # Foreground

      render-loading = true;
      render-loading-fg = "rgba(40,42,54,1)";           # Background
      render-loading-bg = "rgba(248,248,242,1)";        # Foreground

      # Recolor mode settings
      recolor-lightcolor = "rgba(40,42,54,1)";          # Background
      recolor-darkcolor = "rgba(248,248,242,1)";        # Foreground

      # Startup options
      adjust-open = "width";
      recolor = true;
    };
  };
}
