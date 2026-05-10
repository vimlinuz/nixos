{ config, lib, ... }:
{
  options = {
    copilot-lua.enable = lib.mkEnableOption "Enable copilot-lua plugin for nixvim";
  };

  config = lib.mkIf config.copilot-lua.enable {
    programs.nixvim.plugins.copilot-lua = {

      enable = true;
      settings = {
        panel = {
          enabled = false;
          auto_refresh = false;
        };
        suggestion = {
          enabled = false;
          auto_trigger = true;
          debounce = 90;
          # If you’re using a completion plugin (like nvim-cmp), Copilot’s ghost text disappears while the completion menu is visible — avoids clashing with your completion popup.
          hide_during_completion = true;
          # keymap = {
          #   accept = "<tab>";
          #   accept_word = "<C-w>";
          #   accept_line = "<C-f>";
          #   next = "<M-]>";
          #   prev = "<M-[>";
          #   dismiss = "<C-d>";
          # };
        };
        filetypes = {
          "." = false;
          cvs = false;
          gitcommit = true;
          gitrebase = true;
          help = false;
          hgcommit = false;
          markdown = true;
          svn = false;
          yaml = false;
          rs = true;
          js = true;
          html = true;
          nix = true;
          bash = true;
          ts = true;
          lua = true;
          python = true;
        };
      };
    };
  };
}
