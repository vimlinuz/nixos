{ config, ... }:
{
  programs.fish = {
    enable = false;
    generateCompletions = true;
    # interactiveShellInit = "fastfetch";

    shellInit = ''
      set -gx EDITOR nvim

      fish_vi_key_bindings
      fish_vi_cursor

      function fish_user_key_bindings
        fish_vi_key_bindings
        bind -M insert \cf accept-autosuggestion
        bind \cf accept-autosuggestion
      end

      set -U fish_greeting

      # set -gx PATH ${config.home.homeDirectory}/bin $PATH
      set -gx PATH ${config.home.homeDirectory}/.local/bin $PATH
      set -gx PATH ${config.home.homeDirectory}/.local/scripts $PATH
      set -gx PATH ${config.home.homeDirectory}/.cargo/bin $PATH

      carapace _carapace fish | source
    '';

    shellAbbrs = {
      "initialize" = "flake-initializer";
      "b" = "beam";
    };

    shellAliases = {
      "cd" = "z";
      ".." = "cd ..";
      # "ls" = "ls --color";
      "r" = "rm -f (fzf --reverse)";

      "asdf" = "sessionizer";
      "adsf" = "sessionizer";
      "adfs" = "sessionizer";

      "rebuild" = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos/#santosh";

      "gs" = "git status";
      "gl" = "git log --oneline --graph --decorate --all";
      "gd" = "git diff";
      "ga" = "git add -A";
      "c" = "git-commit";
      "P" = "git push origin $(git branch --show-current)";
    };
  };
}
