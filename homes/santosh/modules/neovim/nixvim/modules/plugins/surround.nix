{ config, lib, ... }:
{
  options = {
    surround.enable = lib.mkEnableOption "Enable nvim-surround plugin for nixvim";
  };
  config = lib.mkIf config.surround.enable {
    programs.nixvim.plugins.nvim-surround = {
      enable = true;
    };
  };
}
