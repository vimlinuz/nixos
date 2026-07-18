{ pkgs, ... }:
let
  flakeInitializer = pkgs.writeShellScriptBin "flake-initializer" ''
      #!/usr/bin/env bash
      if [ -z "$1" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
          echo "Usage: $0 <flake-type> [--local]"
          echo "Example: $0 rust"
          echo "Example: $0 rust --local"
          exit 0
      fi

      if [ "$1" = "--list" ] || [ "$1" = "-l" ]; then
          echo "Available flake types:"
          curl -fsSL https://api.github.com/repos/vimlinuz/initflake/contents | ${pkgs.jq}/bin/jq '.[] | select(.type == "dir") | .name'
          exit 0
      fi

      FLAKE_TYPE="$1"
      LOCAL_FLAG="$2"

      if [ "$LOCAL_FLAG" = "--local" ]; then
          echo "Setting up local flake files..."
          wget -q "https://raw.githubusercontent.com/vimlinuz/initflake/main/$FLAKE_TYPE/flake.nix"
          wget -q "https://raw.githubusercontent.com/vimlinuz/initflake/main/$FLAKE_TYPE/flake.lock"
          wget -q "https://raw.githubusercontent.com/vimlinuz/initflake/main/$FLAKE_TYPE/treefmt.nix"

          if [ -d ".git" ]; then
              echo "Git repository detected, adding files to git..."

              echo ".direnv/" >>.gitignore

              git add .gitignore
              git commit -m "chore(git): add .direnv to .gitignore"

              echo "use flake" >.envrc

              git add flake.nix treefmt.nix flake.lock .envrc
              git commit -m "chore(flakes): add initial flake.nix"
          else
              echo "No git repository found, skipping git operations"

              echo ".direnv/" >>.gitignore
              echo "use flake" >.envrc
          fi

          direnv allow
          echo "✓ Local flake files downloaded and configured"
      else
          echo "Setting up remote flake reference..."
          echo "use flake \"github:vimlinuz/initflake?dir=$FLAKE_TYPE\"" >.envrc
          direnv allow
          echo "✓ Remote flake configured"
      fi

    echo "Development environment ready!"

  '';
in
{
  home.packages = [ flakeInitializer ];
}
