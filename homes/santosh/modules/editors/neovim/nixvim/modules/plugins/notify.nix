{ config, lib, ... }:
{
  options = {
    notify.enable = lib.mkEnableOption "Enable notify.nvim plugin for nixvim";
  };
  config = lib.mkIf config.notify.enable {
    programs.nixvim.plugins.notify = {
      enable = true;
      settings = {
        # simple is also good option here
        render = "simple";
        stages = "slide";
        background_colour = "#000000";
        fps = 60;
        level = "info";
      };
    };
  };
}
