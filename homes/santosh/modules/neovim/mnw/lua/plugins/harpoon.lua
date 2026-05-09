require("harpoon"):setup({})
local harpoon_maps = {
  {
    action = function()
      require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
    end,
    key = "<leader>H",
    mode = "n",
    options = { desc = "Toogle harpoon ui" },
  },
  {
    action = function()
      require("harpoon"):list():add()
    end,
    key = "<leader>h",
    mode = "n",
    options = { desc = "Add current buffer in harpoons list" },
  },
  {
    action = function()
      require("harpoon"):list():select(1)
    end,
    key = "<leader>d",
    mode = "n",
    options = { desc = "Select 1 ih list of harpoon" },
  },
  {
    action = function()
      require("harpoon"):list():select(2)
    end,
    key = "<leader>f",
    mode = "n",
    options = { desc = "Select 2 in list of harpoon" },
  },
  {
    action = function()
      require("harpoon"):list():select(3)
    end,
    key = "<leader>j",
    mode = "n",
    options = { desc = "Select 3 in list of harpoon" },
  },
  {
    action = function()
      require("harpoon"):list():select(4)
    end,
    key = "<leader>k",
    mode = "n",
    options = { desc = "Select 4 in list of harpoon" },
  },
  {
    action = function()
      require("harpoon"):list():next()
    end,
    key = "<leader>>",
    mode = "n",
    options = { desc = "Next harpoon buffer" },
  },
  {
    action = function()
      require("harpoon"):list():prev()
    end,
    key = "<leader><",
    mode = "n",
    options = { desc = "Previous harpoon buffer" },
  },
}
for _, map in ipairs(harpoon_maps) do
  vim.keymap.set(map.mode, map.key, map.action, map.options)
end
