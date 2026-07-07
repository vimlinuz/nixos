{ config, pkgs, ... }:
let
  bat = "${pkgs.bat}/bin/bat";
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      # PS1=\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\]
      PS1='\n\[\033[1;37m\]\w\[\033[0m\]\n\[\033[1;37m\]✦ ❯\[\033[0m\] '
      set -o vi
    '';

    # number of lines
    historySize = 1000000;
    historyFileSize = 1000000;
    historyFile = "${config.home.homeDirectory}/.bash_history";

    historyIgnore = [
      "exit"
      "ls"
    ];
    shellAliases = {
      cd = "z";
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
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

    bashrcExtra = ''
      export PATH=$PATH:${config.home.homeDirectory}/.local/scripts

      export FZF_CTRL_T_OPTS="
        --walker-skip .git,node_modules,target,.direnv
        --preview 'bat -n --color=always {}'
        --bind 'ctrl-/:change-preview-window(down|hidden|)'"

      export FZF_ALT_C_OPTS="
        --walker-skip .git,node_modules,target
        --preview 'tree -C {}'"

      export CARAPACE_BRIDGES='bash'
    '';
  };
}
