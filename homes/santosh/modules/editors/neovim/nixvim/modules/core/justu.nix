{ config, lib, ... }:
{
  options = {
    justu.enable = lib.mkEnableOption "Enable animated copilot spinner for nix";
  };
  config = lib.mkIf config.justu.enable {
    programs.nixvim.extraConfigLua = ''
      local spinner = {
      	max_length = 73,
      	min_length = 1,
      	max_distance_from_cursor = 10,
      	max_lines = 3,
      	repeat_ms = 50,

          -- stylua: ignore
          -- chars = { "ሀ", "ሁ", "ሂ", "ሃ", "ሄ", "ህ", "ሆ", "ሇ", "ለ", "ሉ", "ሊ", "ላ", "ሌ", "ል", "ሎ", "ሏ", "ሐ", "ሑ", "ሒ", "ሓ",
          --     "ሔ", "ሕ", "ሖ", "ሗ", "መ", "ሙ", "ሚ", "ማ", "ሜ", "ም", "ሞ", "ሟ", "ሠ", "ሡ", "ሢ", "ሣ", "ሤ", "ሥ", "ሦ", "ሧ",
          --     "ረ", "ሩ", "ሪ", "ራ", "ሬ", "ር", "ሮ", "ሯ", "ሰ", "ሱ", "ሲ", "ሳ", "ሴ", "ስ", "ሶ", "ሷ", "ሸ", "ሹ", "ሺ", "ሻ",
          --     "ሼ", "ሽ", "ሾ", "ሿ", "ቀ", "ቁ", "ቂ", "ቃ", "ቄ", "ቅ", "ቆ", "ቇ", "ቈ", "ቊ", "ቋ", "ቌ", "ቍ", "ቐ", "ቑ", "ቒ",
          --     "ቓ", "ቔ", "ቕ", "ቖ", "ቘ", "ቚ", "ቛ", "ቜ", "ቝ", "በ", "ቡ", "ቢ", "ባ", "ቤ", "ብ", "ቦ", "ቧ", "ቨ", "ቩ", "ቪ",
          --     "ቫ", "ቬ", "ቭ", "ቮ", "ቯ", "ተ", "ቱ", "ቲ", "ታ", "ቴ", "ት", "ቶ", "ቷ", "ቸ", "ቹ", "ቺ", "ቻ", "ቼ", "ች", "ቾ", "ቿ",
          --     "ኀ", "ኁ", "ኂ", "ኃ", "ኄ", "ኅ", "ኆ", "ኇ", "ኈ", "ኊ", "ኋ", "ኌ", "ኍ", "ነ", "ኑ", "ኒ", "ና", "ኔ", "ን", "ኖ",
          --     "ኗ", "ኘ", "ኙ", "ኚ", "ኛ", "ኜ", "ኝ", "ኞ", "ኟ", "አ", "ኡ", "ኢ", "ኣ", "ኤ", "እ", "ኦ", "ኧ", "ከ", "ኩ", "ኪ",
          --     "ካ", "ኬ", "ክ", "ኮ", "ኯ", "ኰ", "ኲ", "ኳ", "ኴ", "ኵ", "኶", "኷", "ኸ", "ኹ", "ኺ", "ኻ", "ኼ", "ኽ", "ኾ", "ዀ",
          --     "ዂ", "ዃ", "ዄ", "ዅ", "዆", "዇", "ወ", "ዉ", "ዊ", "ዋ", "ዌ", "ው", "ዎ", "ዏ", "ዐ", "ዑ", "ዒ", "ዓ", "ዔ", "ዕ",
          --     "ዖ", "዗", "ዘ", "ዙ", "ዚ", "ዛ", "ዜ", "ዝ", "ዞ", "ዟ", "ዠ", "ዡ", "ዢ", "ዣ", "ዤ", "ዥ", "ዦ", "ዧ", "የ", "ዩ"
          -- },
           chars = { "愛", "和", "平", "友", "幸", "福", "夢", "希望", "未来", "光", "心", "空", "海", "山", "花", "風", "月", "星", "雨", "雪",
               "火", "水", "木", "金", "土", "日", "月", "時", "美", "静", "強", "弱", "楽", "歌", "舞", "書", "学", "知", "智", "勇",
               "龍", "虎", "鳥", "魚", "犬", "猫", "馬", "鹿", "羊", "豚", "熊", "猿", "鷹", "鯨", "蝶", "蜂", "花", "葉", "森", "川",
               "山", "田", "石", "岩", "空", "雲", "風", "雨", "雪", "雷", "電", "光", "影", "音", "声", "言", "語", "文", "詩", "書",
               "画", "絵", "美", "芸", "術", "道", "心", "愛", "夢", "希望", "未来", "自由", "平和", "幸福", "友情", "努力", "成功", "感謝", "尊敬"
           },
          rand_hl_group = "CopilotSpinnerHLGroup",
          ns = vim.api.nvim_create_namespace("custom_copilot_spinner"),
          timer = nil,
      }

      function spinner:next_string()
      	local result = {}
      	local spaces = math.random(0, self.max_distance_from_cursor)
      	for _ = 1, spaces do
      		table.insert(result, " ")
      	end

      	local length = math.random(self.min_length, self.max_length)
      	for _ = 1, length do
      		local index = math.random(1, #self.chars)
      		table.insert(result, self.chars[index])
      	end

      	return table.concat(result)
      end

      function spinner:reset()
      	vim.api.nvim_buf_clear_namespace(0, self.ns, 0, -1)
      	if self.timer then
      		self.timer:stop()
      		self.timer = nil
      	end
      end

      vim.api.nvim_create_autocmd({ "CursorMovedI", "InsertLeave" }, {
      	callback = function()
      		spinner:reset()
      	end,
      })

      require("copilot.status").register_status_notification_handler(function(data)
      	spinner:reset()
      	if data.status ~= "InProgress" then
      		return
      	end

      	if spinner.timer then
      		spinner.timer:stop()
      	end
      	spinner.timer = vim.uv.new_timer()
      	if not spinner.timer then
      		return
      	end

      	spinner.timer:start(
      		0,
      		spinner.repeat_ms,
      		vim.schedule_wrap(function()
      			if require("copilot.suggestion").is_visible() then
      				spinner:reset()
      				return
      			end

      			local pos = vim.api.nvim_win_get_cursor(0)
      			local cursor_row, cursor_col = pos[1] - 1, pos[2]
      			local cursor_line = vim.api.nvim_buf_get_lines(0, cursor_row, cursor_row + 1, false)[1] or ""
      			if cursor_col > #cursor_line then
      				cursor_col = #cursor_line
      			end

      			vim.api.nvim_set_hl(0, spinner.rand_hl_group, {
      				fg = "#" .. string.format("%02x", math.random(133, 255)) .. "0044",
      				bold = true,
      			})

      			local extmark_ids = {}
      			local num_lines = math.random(1, spinner.max_lines)
      			local buf_line_count = vim.api.nvim_buf_line_count(0)

      			for i = 1, num_lines do
      				local row = cursor_row + i - 1
      				if row >= buf_line_count then
      					break
      				end
      				local col = (i == 1) and cursor_col or 0

      				local extmark_id = vim.api.nvim_buf_set_extmark(0, spinner.ns, row, col, {
      					virt_text = { { spinner:next_string(), spinner.rand_hl_group } },
      					virt_text_pos = "overlay",
      					priority = 0,
      				})
      				table.insert(extmark_ids, extmark_id)
      			end

      			vim.defer_fn(function()
      				for _, extmark_id in ipairs(extmark_ids) do
      					pcall(vim.api.nvim_buf_del_extmark, 0, spinner.ns, extmark_id)
      				end
      			end, spinner.repeat_ms + math.random(1, 100))
      		end)
      	)
      end)

    '';
  };
}
