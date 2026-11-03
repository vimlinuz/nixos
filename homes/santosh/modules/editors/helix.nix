{
  programs.helix = {
    enable = true;
    languages = {
      language = [
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "nix";
          auto-format = true;
        }
      ];

    };
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
  };
}
