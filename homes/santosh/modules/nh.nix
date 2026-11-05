{
  config,
  pkgs,
  ...
}:
{
  programs.nh = {
    enable = true;
    package = pkgs.nh;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "${config.home.homeDirectory}/nixos";
  };
}
