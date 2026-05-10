{ config, lib, ... }:
{
  options = {
    avante.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable avante.nvim (AI assistant for nvim)";
    };
  };
  config = lib.mkIf config.avante.enable {
    programs.nixvim.plugins.avante = {
      enable = true;
      settings = {
        provider = "copilot";
        model = "gpt-4";
        window = {
          border = "rounded";
          wrapping = true;
        };
      };
    };
  };
}
