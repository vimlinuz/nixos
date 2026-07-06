{ config, pkgs, ... }:
let
  bat = "${pkgs.bat}/bin/bat";
in
{
  programs.nushell = {
    enable = false;
    settings = {
      show_banner = false;
    };

    # environmentVariables = {
    #   EDITOR = "nvim";
    #   WALLPAPER_ARCHIVE_PATH =
    #     "${config.home.sessionVariables.WALLPAPER_ARCHIVE_PATH}";
    # };
    environmentVariables = config.home.sessionVariables;

    # configFile.text = ''
    #   $env.config.edit_mode = 'vi'
    #   $env.prompt_indicator_vi_insert = ""
    #   $env.prompt_indicator_vi_normal = "❮"
    # '';

    extraEnv = ''
      # $env.PATH = ($env.PATH | split row (char esep) | prepend "${config.home.homeDirectory}/bin")
      $env.PATH = ($env.PATH | split row (char esep) | prepend "${config.home.homeDirectory}/.local/bin")
      $env.PATH = ($env.PATH | split row (char esep) | prepend "${config.home.homeDirectory}/.local/scripts")
      $env.PATH = ($env.PATH | split row (char esep) | prepend "${config.home.homeDirectory}/.cargo/bin")
    '';

    # extraConfig = let
    #   nu_scripts = pkgs.fetchFromGitHub {
    #     owner = "nushell";
    #     repo = "nu_scripts";
    #     rev = "156a0110c724ce3a98327190e8a667657e4ed3c1";
    #     hash = "sha256-O/zqhTFzqhFwCD54iXDfe/9WlqMg2PkiO6TLwUyIxmM=";
    #   };
    #   completions = "${nu_scripts}/custom-completions";
    #   getCompletions = cmd: "${completions}/${cmd}/${cmd}-completions.nu";
    # in ''
    #   use ${getCompletions "git"}
    #   # use ${getCompletions "just"}
    #   use ${getCompletions "nix"}
    #   use ${getCompletions "cargo"}
    #   # use ${getCompletions "bat"}
    #   # use ${getCompletions "gh"}
    #   use ${getCompletions "ssh"}
    #   # use ${getCompletions "typst"}
    #   use ${getCompletions "zoxide"}
    #   # use ${getCompletions "tmux"}
    #
    #   # $env.config.cursor_shape.emacs = "line"
    #
    #   def dev [path?: string] {
    #     nix develop ($path | default '.') --command nu
    #   }
    #
    #   def suspend [] {
    #     systemctl suspend
    #     exit
    #   }
    #
    #   def "jj push" [] {
    #     jj bookmark m (git branch --show-current) --to @
    #     jj git push
    #   }
    # '';

    shellAliases = {
      initialize = "flake-initializer";
      b = "beam";

      cd = "z";
      ".." = "cd ..";
      r = "quick-rm";
      la = "ls -la";

      asdf = "sessionizer";
      adsf = "sessionizer";
      adfs = "sessionizer";

      # rebuild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos/#santosh";
      rebuild = "nh os switch ${config.home.homeDirectory}/nixos/#santosh";

      gs = "git status";
      gl = "git log --oneline --graph --decorate --all";
      ga = "git add -A";
      c = "git-commit";
      P = "git push origin (git branch --show-current)";
    };

    extraConfig = ''
      def gd [] { git diff | ${bat} }
    '';
  };

}
