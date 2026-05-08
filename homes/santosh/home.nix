{
  imports = [
    # ╭───────────────────────────────────────────────╮
    # │ Hyprland Configuration Modules                │
    # ╰───────────────────────────────────────────────╯
    ./modules/hypr/hyprland/hyprland.nix
    ./modules/hypr/hypridle.nix
    ./modules/hypr/hyprpaper.nix
    ./modules/hypr/hyprlock.nix
    ./modules/hypr/hyprsunset.nix

    # ╭───────────────────────────────────────────────╮
    # │ Terminals                                     │
    # ╰───────────────────────────────────────────────╯
    ./modules/terminals/kitty.nix
    ./modules/terminals/alacritty/alacritty.nix
    ./modules/terminals/ghostty/ghostty.nix

    # ╭───────────────────────────────────────────────╮
    # │ General Utility Modules                       │
    # ╰───────────────────────────────────────────────╯
    ./modules/gtk.nix
    ./modules/fastfetch.nix
    ./modules/starship/starship.nix
    ./modules/zoxide.nix
    ./modules/btop.nix
    ./modules/bat.nix
    ./modules/rofi.nix
    ./modules/wlsunset.nix
    ./modules/nh.nix
    ./modules/zathura.nix

    ./modules/git.nix
    ./modules/direnv.nix
    ./modules/gh.nix

    # ╭───────────────────────────────────────────────╮
    # │ Code editors                                  │
    # ╰───────────────────────────────────────────────╯
    # ./modules/nixvim/nixvim.nix
    ./modules/vim.nix
    ./modules/zed.nix
    ./modules/helix.nix
    ./modules/nvim/nvim.nix

    # ╭───────────────────────────────────────────────╮
    # │ Shell                                         │
    # ╰───────────────────────────────────────────────╯
    ./modules/shell/fish.nix
    ./modules/shell/nushell.nix
    ./modules/shell/carapace.nix
    ./modules/shell/bash.nix

    # ╭───────────────────────────────────────────────╮
    # │ Wayland and Terminal Tools                    │
    # ╰───────────────────────────────────────────────╯
    ./modules/waybar/default.nix
    ./modules/swaync.nix
    ./modules/tmux/default.nix

    # ╭───────────────────────────────────────────────╮
    # │ Package Management                            │
    # ╰───────────────────────────────────────────────╯
    ./modules/pkgs/default.nix

    # ╭───────────────────────────────────────────────╮
    # │ Scripts                                       │
    # ╰───────────────────────────────────────────────╯
    ./modules/scripts/sessionizer.nix
    ./modules/scripts/music-player.nix
    ./modules/scripts/cliphist-reset.nix

    ./modules/scripts/clipManager.nix
    ./modules/scripts/pomodoro.nix
    ./modules/scripts/quick-rm.nix
    ./modules/scripts/flake-initializer.nix

    # ╭───────────────────────────────────────────────╮
    # │ Wallpapers                                    │
    # ╰───────────────────────────────────────────────╯
    ./modules/scripts/rofi-wallpaper-selector.nix

    # ╭───────────────────────────────────────────────╮
    # │  Ricing                                        │
    # ╰───────────────────────────────────────────────╯
    ./modules/cursor.nix

    # ╭───────────────────────────────────────────────╮
    # │  Browsers                                     │
    # ╰───────────────────────────────────────────────╯
    ./modules/firefox/firefox.nix
    ./modules/zen-browser.nix
    ./modules/qute-browser.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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
    ".config/kitty" = {
      source = ./config/kitty;
      recursive = true;
    };
    ".local/scripts" = {
      source = ./scripts;
      recursive = true;
    };
    ".config/rofi" = {
      source = ./config/rofi;
      recursive = true;
    };
    ".config/niri" = {
      source = ./config/niri;
      recursive = true;
    };
  };

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

  nh.enable = true;
}
