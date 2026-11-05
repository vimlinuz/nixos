{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = "vimlinuz@gmail.com";
        name = "vimlinuz";
      };

      # Jujutsu does not run Git hooks. Run `jj fmt` before `jj new` to
      # format the working copy with the flake's treefmt configuration.
      aliases = {
        fmt = [
          "util"
          "exec"
          "--"
          "nix"
          "fmt"
        ];
      };
    };
  };
}
