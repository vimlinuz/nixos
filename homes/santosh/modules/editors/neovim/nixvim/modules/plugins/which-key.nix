{ config, lib, ... }:
{
  options = {
    which-key.enable = lib.mkEnableOption "Enable which-key plugin for nixvim";
  };
  config = lib.mkIf config.which-key.enable {
    programs.nixvim.plugins.which-key = {
      enable = true;
      settings = {
        win = {
          # 0 for fully opaque and 100 for fully transparent.
          wo.winblend = 0;
          zindex = 1000;
        };
        notify = true;
        # preset = "modern";
        preset = "helix";
        plugins = {
          marks = true;
          registers = true;
        };
      };
    };
  };
}
