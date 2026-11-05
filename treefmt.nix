{
  # Single formatter configuration for the whole repository.
  # Everything is indented with two spaces and spaces are preferred over tabs
  # for every file type handled here. `.editorconfig` mirrors these settings
  # for editors and for anything treefmt does not touch.
  ...
}:
{
  # Locate the project root by looking for this file.
  projectRootFile = "flake.nix";

  programs = {
    # nixfmt always uses two-space indentation and has no options.
    nixfmt.enable = true;

    # Lua: two spaces, no tabs.
    stylua = {
      enable = true;
      settings = {
        indent_type = "Spaces";
        indent_width = 2;
      };
    };

    # Shell scripts: two spaces, no tabs.
    shfmt = {
      enable = true;
      indent_size = 2;
      simplify = true;
    };

    # Markdown, CSS, YAML, and JSON: two spaces, no tabs.
    prettier = {
      enable = true;
      settings = {
        tabWidth = 2;
        useTabs = false;
      };
    };

    # TOML: two spaces, no tabs.
    taplo = {
      enable = true;
      settings.formatting.indent_string = "  ";
    };

    # *.kdl (Niri configuration) is intentionally left unformatted.
    # kdlfmt 0.1.7 collapses blank lines and rewrites the multi-line
    # custom-shader r"..." blocks into single-line escaped strings, which
    # makes the shader code unreadable. Re-enable only if that changes.
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
