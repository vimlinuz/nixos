{ inputs, ... }:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          black-metal-theme-neovim = prev.vimUtils.buildVimPlugin {
            name = "black-metal-theme-neovim";
            src = inputs.black-metal-theme-neovim;
          };
        };
      })
    ];
  };
}
