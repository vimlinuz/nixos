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
    };
  };
}
