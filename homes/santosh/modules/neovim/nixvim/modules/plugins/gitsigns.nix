{ config, lib, ... }:
{
  options = {
    gitsigns.enable = lib.mkEnableOption "Enable gitsigns plugin for nixvim";
  };
  config = lib.mkIf config.gitsigns.enable {
    programs.nixvim.plugins.gitsigns = {
      enable = true;
      settings = {
        signs = {
          add = {
            text = "│";

          };
          change = {
            text = "│";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          changedelete = {
            text = "~";
          };
          untracked = {
            text = "┆";
          };
        };
        signs_staged = {
          add = {
            text = "│";
          };
          change = {
            text = "│";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          changedelete = {
            text = "~";
          };
          untracked = {
            text = "┆";
          };
        };
      };
    };
  };
}
