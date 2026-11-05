{
  lib,
  inputs,
  pkgs,
  ...
}:

{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = lib.recursiveUpdate (fromTOML (builtins.readFile ./config.toml)) {
      wallpaper.directory = "${
        inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.wallpapers
      }/wallpapers";
    };
  };
}
