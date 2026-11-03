{ config, lib, ... }:
{
  options = {
    harpoon.enable = lib.mkEnableOption "Enable harpoon plugin for nixvim";
  };
  config = lib.mkIf config.harpoon.enable {
    programs.nixvim.plugins.harpoon = {
      enableTelescope = true;
      enable = true;

      # settings = {
      #   save_on_toggle = true;
      #   sync_on_ui_close = false;
      # };

      #   menu = {
      #     width.__raw = "vim.api.nvim_win_get_width(0) - 4";
      #     height = 10;
      #   };
    };
  };
}
