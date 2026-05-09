{ config, lib, ... }:
{
  options = {
    indent-blankline.enable = lib.mkEnableOption "Enable indent-blankline plugin for nixvim";
  };
  config = lib.mkIf config.indent-blankline.enable {
    programs.nixvim.plugins.indent-blankline = {
      enable = true;
      settings = {
        indent = {
          char = "│";
        };
        scope = {
          show_start = false;
          show_end = false;
          show_exact_scope = false;
        };
      };
    };
  };
}
