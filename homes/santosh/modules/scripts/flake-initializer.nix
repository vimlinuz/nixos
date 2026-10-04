{ pkgs, ... }:
let
  flakeInitializer = pkgs.writeShellScriptBin "flake-initializer" ''
    RED='\033[31m'
    GREEN='\033[32m'
    RESET='\033[0m'

    if [ ! -t 1 ]; then
      RED=""
      GREEN=""
      RESET=""
    fi

    if [ "$1" = "--list" ] || [ "$1" = "-l" ]; then
        printf "''${GREEN}Available flake types:''${RESET}\n"
        curl -fsSL https://api.github.com/repos/vimlinuz/initflake/contents | ${pkgs.jq}/bin/jq -r '.[] | select(.type == "dir") | .name'
        exit 0
    fi

    FLAKE_TYPE="$1"
    LOCAL_FLAG="$2"

    if [ "$LOCAL_FLAG" = "--local" ] || [ -z "$LOCAL_FLAG" ]; then
        printf "''${GREEN}==> Setting up local flake files...''${RESET}\n"

        if ! wget -q "https://raw.githubusercontent.com/vimlinuz/initflake/main/$FLAKE_TYPE/flake.nix"; then
          printf "''${RED}Error: flake '%s' not found''${RESET}\n" "$FLAKE_TYPE"
          exit 1
        fi

        wget -q "https://raw.githubusercontent.com/vimlinuz/initflake/main/$FLAKE_TYPE/flake.lock"
        wget -q "https://raw.githubusercontent.com/vimlinuz/initflake/main/$FLAKE_TYPE/treefmt.nix"

        if [ -d ".git" ]; then
            printf "''${GREEN}==> Git repository detected, adding files to git...''${RESET}\n"

            echo ".direnv/" >>.gitignore

            git add .gitignore
            git commit -m "chore(git): add .direnv to .gitignore"

            echo "use flake" >.envrc

            git add flake.nix treefmt.nix flake.lock .envrc
            git commit -m "chore(flakes): add initial flake.nix"
        else
            printf "''${RED}==> No git repository found, skipping git operations''${RESET}\n"

            echo ".direnv/" >>.gitignore
            echo "use flake" >.envrc
        fi

        direnv allow
        printf "''${GREEN}✓ Local flake files downloaded and configured''${RESET}\n"
        printf "''${GREEN}✓ Development environment ready!''${RESET}\n"
      exit 0
    fi

    if [ "$LOCAL_FLAG" = "--remote" ] || [ "$LOCAL_FLAG" = "--git" ]; then
        printf "''${GREEN}==> Setting up remote flake reference...''${RESET}\n"
        echo "use flake \"github:vimlinuz/initflake?dir=$FLAKE_TYPE\"" >.envrc
        direnv allow
        printf "''${GREEN}✓ Remote flake configured''${RESET}\n"
        printf "''${GREEN}✓ Development environment ready!''${RESET}\n"
      exit 0
    fi

    printf "''${RED}Usage:''${RESET} %s <flake-type> [--local | --remote | --git]\n" "$0"
    printf "''${RED}Example:''${RESET} %s rust\n" "$0"
    printf "''${RED}Example:''${RESET} %s rust --local\n" "$0"
    printf "''${RED}Example:''${RESET} %s rust --git\n" "$0"
  '';
in
{
  home.packages = [ flakeInitializer ];
}
