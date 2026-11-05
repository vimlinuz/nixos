{ ... }:
{
  # Locate the project root by looking for this file.
  projectRootFile = "flake.nix";

  programs = {
    # *.nix
    nixfmt.enable = true;

    # *.lua
    stylua.enable = true;

    # *.sh and the extensionless scripts under homes/santosh/scripts
    shfmt.enable = true;

    # *.kdl (Niri configuration) is intentionally left unformatted.
    # kdlfmt 0.1.7 collapses blank lines and rewrites the multi-line
    # custom-shader r"..." blocks into single-line escaped strings, which
    # makes the shader code unreadable. Re-enable only if that changes.

    # *.md, *.css, *.yaml, *.json
    prettier.enable = true;

    # *.toml (Noctalia bar configuration)
    taplo.enable = true;
  };

  # shfmt only matches *.sh/*.bash by default, so add the shebang scripts
  # that have no extension.
  programs.shfmt.includes = [
    "*.sh"
    "*.bash"
    "homes/santosh/scripts/*"
  ];

  settings.excludes = [
    # VCS metadata
    ".git/*"
    ".jj/*"

    # Encrypted secrets
    "secrets/*"

    # README assets
    ".github/assets/*"

    # Generated lock file
    "flake.lock"
  ];
}
