-- my telescope customization 
local builtin = require("telescope.builtin")

local M = {}

function M.search_config()
  builtin.find_files({
    prompt_title = " Search Config Files ",
    prompt_prefix = "   ",
    cwd = "~/.config/nvim",
  })
end

-- function M.search_file()
--   builtin.find_files({
--     prompt_title = " Search Files ",
--     prompt_prefix = "  ",
--     find_command = { "rg", "--no-ignore", "--files" },
--     cwd = "~",
--   })
-- end

-- function M.search_repos()
--   require("telescope").extensions.file_browser.file_browser({
--     prompt_title = "Search Repos",
--     prompt_prefix = "  ",
--     cwd = "~/repos/",
--   })
-- end

-- function M.browse_files()
--   require("telescope").extensions.file_browser.file_browser({
--     prompt_title = "Search Workspace",
--     cwd_to_path = true,
--   })
-- end

return M
