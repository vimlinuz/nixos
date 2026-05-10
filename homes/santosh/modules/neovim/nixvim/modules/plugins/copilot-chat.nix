{ config, lib, ... }:
{
  options = {
    copilot-chat.enable = lib.mkEnableOption "Enable copilot-chat plugin for nixvim";
  };

  config = lib.mkIf config.copilot-chat.enable {
    programs.nixvim.plugins.copilot-chat = {
      enable = true;
      settings = {
        headers = {
          assistant = "## Ai ";
          user = "## santosh ";
          tool = "## Tool ";
        };
        show_help = false;
        auto_follow_cursor = true;
        auto_fold = true;
        highlight_selection = false;
        # model = "gpt-5.1-codex";
        # model = "gpt-5.3-codex";
        model = "gpt-4.1";
        window = {
          height = 1;
          width = 1;
          # here we are just removing the border by setting it to none as I am doing the height and width to 100%
          # border = "rounded";
          border = "none";
          # title = "   AutoPilot ";
          title = "─";
          layout = "float";
        };
      };
    };
  };
}
