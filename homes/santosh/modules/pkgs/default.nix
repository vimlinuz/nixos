{
  pkgs,
  inputs,
  ...
}:
let
  waylandPkgs = import ./wayland.nix { inherit pkgs; };
  fontsPkgs = import ./fonts.nix { inherit pkgs; };
  utilsPkgs = import ./utils.nix { inherit pkgs inputs; };
  gamingPkgs = import ./gaming.nix { inherit pkgs; };
  security_tools = import ./security_tools.nix { inherit pkgs; };
in
{
  home.packages = waylandPkgs ++ fontsPkgs ++ utilsPkgs;
  # # Adds the 'hello' command to your environment. It prints a friendly
  # # "Hello, world!" when run.
  # pkgs.hello

  # # It is sometimes useful to fine-tune packages, for example, by applying
  # # overrides. You can do that directly here, just don't forget the
  # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
  # # fonts?
  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  # # You can also create simple shell scripts directly inside your
  # # configuration. For example, this adds a command 'my-hello' to your
  # # environment:
  # (pkgs.writeShellScriptBin "my-hello" ''
  #   echo "Hello, ${config.home.username}!"
  # '')
}
