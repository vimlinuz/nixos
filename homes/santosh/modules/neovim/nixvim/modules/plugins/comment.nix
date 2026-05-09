{ config, lib, ... }:
{
  options = {
    comment.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable comment.nvim (Smart and powerful comment plugin for neovim)";
    };
  };
  config = lib.mkIf config.comment.enable {
    programs.nixvim.plugins.comment = {
      enable = true;
      settings = {
        # Comment.nvim default settings
        padding = true;
        sticky = true;
        ignore = null;
        mappings = {
          basic = false;
          extra = false;
        };
        pre_hook = null;
        post_hook = null;
      };
    };
  };
}
