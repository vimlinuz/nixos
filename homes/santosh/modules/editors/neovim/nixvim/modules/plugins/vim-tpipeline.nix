{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    vim-tpipeline = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable vim-tpipeline plugin for nixvim";
      };
    };
  };
  config = lib.mkIf config.vim-tpipeline.enable {
    programs.nixvim = {
      extraPlugins = [
        (pkgs.vimPlugins.vim-tpipeline)
      ];
    };
  };
}
