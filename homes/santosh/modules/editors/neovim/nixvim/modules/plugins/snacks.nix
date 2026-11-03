{ config, lib, ... }:
{
  options = {
    snacks.enable = lib.mkEnableOption "Enable snacks.nvim plugin for nixvim";
  };
  config = lib.mkIf config.snacks.enable {
    programs.nixvim.plugins.snacks = {
      enable = true;
      settings = {
        notifier = {
          enabled = false;
          style = "fancy";
        };
        bigfile = {
          enabled = true;
          notify = true;
          size = {
            __raw = "1.5 * 1024 * 1024"; # 1.5 MB
          };
        };
        quickfile = {
          enabled = true;
        };
        statuscolumn.enabled = false;
      };
    };
  };
}
