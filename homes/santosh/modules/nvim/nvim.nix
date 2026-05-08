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
      ];

      dev.myconfig = {
        pure = ./.;
        impure = toString ./.;
      };
    };
  };
}
