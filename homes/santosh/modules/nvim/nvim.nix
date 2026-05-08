{
  pkgs,
  ...
}:
{
  programs.mnw = {
    enable = true;
    initLua = ''
      require("init")
    '';
    plugins = {
      start = [
        pkgs.vimPlugins.oil-nvim
        pkgs.vimPlugins.alpha-nvim
        pkgs.vimPlugins.vague-nvim
      ];

      dev.myconfig = {
        pure = ./.;
        impure = toString ./.;
      };
    };
  };
}
