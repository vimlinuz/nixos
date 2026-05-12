{ config, pkgs, ... }:
let
  bat = "${pkgs.bat}/bin/bat";
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # number of lines
    historySize = 1000000;

    historyIgnore = [
      "exit"
      "ls"
    ];
    shellAliases = {
      cd = "z";
      ".." = "cd ..";
      # "ls" = "ls --color";
      r = "rm -f (fzf --reverse)";

      asdf = "sessionizer";
      adsf = "sessionizer";
      adfs = "sessionizer";

      # rebuild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos/#santosh";
      rebuild = "nh os switch ${config.home.homeDirectory}/nixos/#santosh";

      gs = "git status";
      gl = "git log --oneline --graph --decorate --all";
      gd = "git diff | ${bat}";
      ga = "git add -A";
      c = "git-commit";
      P = "git push origin $(git branch --show-current)";
      b = "beam";

      initialize = "flake-initializer";
    };
  };
}
