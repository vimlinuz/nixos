{ pkgs, ... }:
{
  programs.neovide = {
    enable = true;
    settings = {
      fonts = {
        normal = [ pkgs.nerd-fonts.jetbrains-mono ];
        size = 14.0;
      };
      tabs = false;
    };
  };
}
