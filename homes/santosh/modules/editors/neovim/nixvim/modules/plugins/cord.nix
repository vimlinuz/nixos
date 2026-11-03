{ config, lib, ... }:
{
  options = {
    cord.enable = lib.mkEnableOption "Enable cord.nvim plugin for nixvim";
  };
  config = lib.mkIf config.cord.enable {
    programs.nixvim.plugins.cord = {
      enable = true;
      settings = {
        display = {
          show_time = true;
        };
      };
    };
  };
}
