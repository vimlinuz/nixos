{
  config,
  lib,
  ...
}:
{
  options = {
    ufo.enable = lib.mkEnableOption "Enalble ufo.nvim (A Neovim plugin to improve code folding)";
  };
  config = lib.mkIf config.ufo.enable {
    programs.nixvim.plugins.nvim-ufo = {
      enable = true;
      setupLspCapabilities = true;
      settings = {
        # Get fold information from treesitter if possible, it's more intelligent
        provider_selector = ''
          function(bufnr, filetype, buftype)
                  return {'treesitter', 'indent'}
          end
        '';

        # function to handle custom virtual text at the end of fold
        #https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#customize-fold-text
        fold_virt_text_handler = ''
          function(virtText, lnum, endLnum, width, truncate)
              local newVirtText = {}
              local suffix = (' 󰁂 %d '):format(endLnum - lnum)
              local sufWidth = vim.fn.strdisplaywidth(suffix)
              local targetWidth = width - sufWidth
              local curWidth = 0
              for _, chunk in ipairs(virtText) do
                  local chunkText = chunk[1]
                  local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                  if targetWidth > curWidth + chunkWidth then
                      table.insert(newVirtText, chunk)
                  else
                      chunkText = truncate(chunkText, targetWidth - curWidth)
                      local hlGroup = chunk[2]
                      table.insert(newVirtText, {chunkText, hlGroup})
                      chunkWidth = vim.fn.strdisplaywidth(chunkText)
                      -- str width returned from truncate() may less than 2nd argument, need padding
                      if curWidth + chunkWidth < targetWidth then
                          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                      end
                      break
                  end
                  curWidth = curWidth + chunkWidth
              end
              table.insert(newVirtText, {suffix, 'MoreMsg'})
              return newVirtText
          end
        '';

      };
    };

  };
}
