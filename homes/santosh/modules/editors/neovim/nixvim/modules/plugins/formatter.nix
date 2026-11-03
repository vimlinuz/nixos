{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    formatter.enable = lib.mkEnableOption "Enable formatter for nixvim";
  };
  config = lib.mkIf config.formatter.enable {
    programs.nixvim.plugins.lsp-format = {
      enable = true;
      lspServersToEnable = [
        "dockerls"
        "gopls"
        "nushell"
        "rust_analyzer"
        "pylsp"
      ];
    };
    programs.nixvim.plugins.none-ls = {
      enable = true;
      enableLspFormat = true;
      sources.formatting = {
        prettier = {
          package = pkgs.prettier;
          enable = true;
          settings.filetypes = [
            "css"
            "html"
            "json"
            "yaml"
            "markdown"
            "javascript"
            "typescript"
            "typescriptreact"
          ];
          # Disable the TypeScript Language Server's built-in formatter to avoid conflicts
          disableTsServerFormatter = true;
        };

        stylua.enable = true;

        shfmt = {
          enable = true;
          settings.extra_args = [
            "-i"
            "4"
          ];
        };

        clang_format.enable = true;

        nixfmt = {
          enable = true;
          package = pkgs.nixfmt;
        };
      };
    };
  };

  # programs.nixvim.autoCmd = [{
  #   event = "BufWritePre";
  #   pattern = "*";
  #   callback.__raw = ''
  #     function()
  #     vim.lsp.buf.format({ async = false })
  #     end
  #   '';
  # }];
  # This is commented out to avoid conflicts with lsp-format or none-ls,
  # which already handle formatting on save.
}
