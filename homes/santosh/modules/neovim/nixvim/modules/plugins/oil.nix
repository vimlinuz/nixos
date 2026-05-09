{ config, lib, ... }:
{
  options = {
    oil.enable = lib.mkEnableOption "Enable oil.nvim plugin for nixvim";
  };
  config = lib.mkIf config.oil.enable {
    programs.nixvim.plugins.oil = {
      enable = true;
      settings = {
        delete_to_trash = true;
        default_file_explorer = true;
        watch_for_changes = true;
        win_options = {
          wrap = true;
        };

        keymaps = {
          "<C-l>" = false;
          "<C-h>" = false;
          "<C-p>" = false;

          "<C-r>" = "actions.refresh";
          # "<C-o>" = "actions.select";
          "<C-v>" = "actions.select_vsplit";
        };
        skip_confirm_for_simple_edits = true;
        use_default_keymaps = true;
        view_options = {
          show_hidden = true;
          natural_order = true;
        };
      };
    };
  };
}
