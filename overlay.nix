{ inputs, ... }:
{
  nixpkgs = {
    overlays = [
      (
        final: prev:
        let
          generated = (
            (final.callPackage /home/santosh/dev/nixpkgs/pkgs/applications/editors/vim/plugins/generated.nix {
              buildVimPlugin = prev.vimUtils.buildVimPlugin;
            })
              final
              prev
          );
        in
        {
          vimPlugins = prev.vimPlugins // {
            black-metal-theme-neovim = prev.vimUtils.buildVimPlugin {
              name = "black-metal-theme-neovim";
              src = inputs.black-metal-theme-neovim;
            };
            blink-calc = generated.blink-calc;
          };
        }
      )
    ];
  };
}
