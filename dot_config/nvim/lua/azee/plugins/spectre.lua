return {
  'nvim-pack/nvim-spectre',
  build = false,
  cmd = 'Spectre',
  opts = { open_cmd = 'noswapfile vnew' },
  -- stylua: ignore
  keys = {
    -- Needs brew install gnu-sed
    -- { "<leader>rn", function() require("spectre").toggle() end, desc = "Replace in files (Spectre)" },
    { "<leader>rn", function() require("spectre").open_visual({select_word=true}) end, desc = "Global Search (Spectre)" },
    { "<leader>rn", function() vim.cmd([[<esc>]]) require("spectre").open_visual() end, mode = 'v', desc = "Search in visual mode" },
    { "<leader>rf", function() require("spectre").open_file_search({select_word=true}) end, desc = "Search on current file" },
  },
}
