{ pkgs, ... }:
{
  plugin = pkgs.tmuxPlugins.tmux-sm;
  extraConfig = ''
    set -g @sessionizer_key '-n M-i'
    set -g @sessionizer_height '70%'
    set -g @sessionizer_width '80%'
    set -g @session_manager_width '35%'
  '';
}
