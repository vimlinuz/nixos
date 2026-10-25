{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    plymouth.enable = lib.mkEnableOption "Enable Plymouth for a graphical boot splash screen";
  };
  config = lib.mkIf config.plymouth.enable {
    boot = {
      plymouth = {
        enable = true;
        theme = "hud_3";
        # logo = pkgs.fetchurl {
        #   url = "https://raw.githubusercontent.com/vimlinuz/nixos/refs/heads/main/.github/assets/nix-snowflake-colours.svg";
        #   sha256 = "sha256-43taHBHoFJbp1GrwSQiVGtprq6pBbWcKquSTTM6RLrI=";
        # };
        themePackages = with pkgs; [
          # https://github.com/adi1090x/plymouth-themes?tab=readme-ov-file
          (adi1090x-plymouth-themes.override {
            selected_themes = [
              "connect"
              "circle_hud"
              "cuts_alt"
              "deus_ex"
              "double"
              "hexagon_dots"
              "hexagon_dots_alt"
              "hud_3"
              "spinner_alt"
            ];
          })
          # nixos-bgrt
          nixos-bgrt-plymouth
        ];
      };

      consoleLogLevel = 3;
      kernelParams = [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
      ];

    };
  };
}
