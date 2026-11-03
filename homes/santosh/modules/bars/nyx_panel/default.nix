{ lib, inputs, ... }:

{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = lib.recursiveUpdate (fromTOML (builtins.readFile ./config.toml)) {
      wallpaper.directory = "${inputs.wall-archive}/wallpapers";
    };
  };
}
