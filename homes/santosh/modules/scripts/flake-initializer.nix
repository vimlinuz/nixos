{ pkgs, ... }:
let
  flakeInitializer = pkgs.writeShellScriptBin "flake-initializer" ''
    if [ "$1" = "--list" ] || [ "$1" = "-l" ]; then
        echo "Available flake types:"
        curl -fsSL https://api.github.com/repos/vimlinuz/initflake/contents | ${pkgs.jq}/bin/jq '.[] | select(.type == "dir") | .name'
        exit 0
    fi

    FLAKE_TYPE="$1"
    LOCAL_FLAG="$2"

    if [ "$LOCAL_FLAG" = "--local" ] || [ -z "$LOCAL_FLAG" ]; then
        echo "Setting up local flake files..."

        if ! wget -q "https://raw.githubusercontent.com/vimlinuz/initflake/main/$FLAKE_TYPE/flake.nix"; then
          echo "Error: flake not found"
          exit 1
        fi

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
        echo "Development environment ready!"
      exit 0
    fi

    if [ "$LOCAL_FLAG" = "--remote" ] || [ "$LOCAL_FLAG" = "--git" ]; then
        echo "Setting up remote flake reference..."
        echo "use flake \"github:vimlinuz/initflake?dir=$FLAKE_TYPE\"" >.envrc
        direnv allow
        echo "✓ Remote flake configured"
        echo "Development environment ready!"
      exit 0
    fi

    echo "Usage: $0 <flake-type> [--local | --remote | --git]"
    echo "Example: $0 rust"
    echo "Example: $0 rust --local"
    echo "Example: $0 rust --git"
  '';
in
{
  home.packages = [ flakeInitializer ];
}
