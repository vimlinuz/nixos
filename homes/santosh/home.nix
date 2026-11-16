{
  imports = [
    # ╭───────────────────────────────────────────────╮
    # │ Terminals                                     │
    # ╰───────────────────────────────────────────────╯
    ./modules/terminals/kitty.nix
    ./modules/terminals/alacritty/alacritty.nix
    ./modules/terminals/ghostty/ghostty.nix
    ./modules/terminals/foot.nix

    ./modules/tmux/default.nix

    # ╭───────────────────────────────────────────────╮
    # │ General Utility Modules                       │
    # ╰───────────────────────────────────────────────╯
    ./modules/fzf.nix
    ./modules/eza.nix
    ./modules/lsd.nix
    ./modules/kdeconnect.nix
    ./modules/zoxide.nix
    ./modules/btop.nix
    ./modules/bat.nix
    ./modules/nh.nix
    ./modules/zathura.nix
    ./modules/direnv.nix

    # ╭───────────────────────────────────────────────╮
    # │ Theming                                       │
    # ╰───────────────────────────────────────────────╯
    ./modules/gtk.nix

    # ╭───────────────────────────────────────────────╮
    # │ Version Control Systems                       │
    # ╰───────────────────────────────────────────────╯
    ./modules/git.nix
    ./modules/gh.nix
    ./modules/jujutsu.nix

    ./modules/opencode.nix

    # ╭───────────────────────────────────────────────╮
    # │ File Managers                                 │
    # ╰───────────────────────────────────────────────╯
    ./modules/yazi.nix

    ./modules/vesktop/vesktop.nix

    # ╭───────────────────────────────────────────────╮
    # │ editors                                       │
    # ╰───────────────────────────────────────────────╯
    ./modules/editors/neovim/mnw/nvim.nix
    ./modules/editors/vim.nix
    ./modules/editors/neovim/neovide.nix
    ./modules/editors/zed.nix
    ./modules/editors/helix.nix
    ./modules/editors/obsidian.nix

    # ╭───────────────────────────────────────────────╮
    # │ Shell                                         │
    # ╰───────────────────────────────────────────────╯
    ./modules/shell/carapace.nix
    ./modules/shell/bash.nix
    ./modules/shell/atuin.nix

    # ╭───────────────────────────────────────────────╮
    # │ Bars                                          │
    # ╰───────────────────────────────────────────────╯
    ./modules/bars/nyx_panel/default.nix

    # ╭───────────────────────────────────────────────╮
    # │ Package Management                            │
    # ╰───────────────────────────────────────────────╯
    ./modules/pkgs/default.nix

    # ╭───────────────────────────────────────────────╮
    # │ Scripts                                       │
    # ╰───────────────────────────────────────────────╯
    ./modules/scripts/sessionizer.nix
    ./modules/scripts/music-player.nix
    ./modules/scripts/pomodoro.nix
    ./modules/scripts/flake-initializer.nix
    ./modules/scripts/pull.nix

    ./modules/cursor.nix
    ./modules/cava.nix

    # ╭───────────────────────────────────────────────╮
    # │ Browsers                                      │
    # ╰───────────────────────────────────────────────╯
    ./modules/browsers/zen-browser.nix
  ];

  home.username = "santosh";
  home.homeDirectory = "/home/santosh";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/kitty" = {
      source = ./config/kitty;
      recursive = true;
    };
    ".local/scripts" = {
      source = ./scripts;
      recursive = true;
    };
    ".config/niri" = {
      source = ./config/niri;
      recursive = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/santosh/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
