Statusline = {}

-- Import highlights, icons and function
require("orcnvim.ui.highlight").statusline_highlight()
local icon = require("orcnvim.icons")
local is_empty = require("orcnvim.utils").isempty
local is_match = require("orcnvim.utils").ismatch
local devicon = require("orcnvim.utils").get_icons
-- Add filetypes to the list for which you don't want statusline before unpack statement
local disable_statusline = {
  "TelescopePrompt",
  "lazy",
  "NvimTree",
  unpack(require("orcnvim.utils").disable() or {}),
}

local function update_mode_colors()
  local mode_colors = {
    n = "%#StatusLineAccent#",
    no = "%#StatusLineAccent#",
    i = "%#StatusLineInsertAccent#",
    ic = "%#StatusLineInsertAccent#",
    v = "%#StatusLineVisualAccent#",
    V = "%#StatusLineVisualAccent#",
    ["\22"] = "%#StatusLineVisualAccent#", -- CTRL-V (Visual Block)
    R = "%#StatusLineReplaceAccent#",
    c = "%#StatusLineCmdLineAccent#",
    t = "%#StatusLineTerminalAccent#",
  }
  return mode_colors[vim.api.nvim_get_mode().mode] or ""
end

local function mode()
  local modes = {
    n = "NORMAL",
    no = "O-PENDING",
    nov = "O-PENDING",
    noV = "O-PENDING",
    ["no\22"] = "O-PENDING",
    niI = "NORMAL",
    niR = "NORMAL",
    niV = "NORMAL",
    nt = "NORMAL",
    ntT = "NORMAL",
    v = "VISUAL",
    vs = "VISUAL",
    V = "V-LINE",
    Vs = "V-LINE",
    ["\22"] = "V-BLOCK",
    ["\22s"] = "V-BLOCK",
    s = "SELECT",
    S = "S-LINE",
    ["\19"] = "S-BLOCK",
    i = "INSERT",
    ic = "INSERT",
    ix = "INSERT",
    R = "REPLACE",
    Rc = "REPLACE",
    Rx = "REPLACE",
    Rv = "V-REPLACE",
    Rvc = "V-REPLACE",
    Rvx = "V-REPLACE",
    c = "COMMAND",
    cv = "EX",
    ce = "EX",
    r = "REPLACE",
    rm = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    t = "TERMINAL",
  }

  local current_mode = vim.api.nvim_get_mode().mode
  local mode_text = modes[current_mode] or ""
  return update_mode_colors() .. icon.ui.Neovim .. " " .. mode_text .. "%#Normal#"
end

local function filename()
  return vim.fn.expand("%:t") or ""
end

local git = function()
  local git_info = vim.b.gitsigns_status_dict

  if is_empty(git_info) then
    return ""
  end

  local render_git = {
    string.format("%%#DevIcon.git#%s %s", icon.git.Branch, git_info.head),
  }

  local git_stats = {
    { group = "GitSignsAdd", icon = icon.git.LineAdded, value = git_info.added },
    { group = "GitSignsChange", icon = icon.git.LineModified, value = git_info.changed },
    { group = "GitSignsDelete", icon = icon.git.LineRemoved, value = git_info.removed },
  }

  for _, stat in ipairs(git_stats) do
    if not is_empty(stat.value) then
      render_git[#render_git + 1] = string.format("%%#%s#%s %s", stat.group, stat.icon, stat.value)
    end
  end
  return table.concat(render_git, " ")
end

local function lsp()
  local lsp_icon = icon.ui.Gear
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if vim.tbl_isempty(clients) then
    return ""
  end
  local active_clients = {}
  for _, client in ipairs(clients) do
    active_clients[#active_clients + 1] = client.name
  end
  return string.format("%%#Conditional#[%s %s]", lsp_icon, table.concat(active_clients, " "))
end

local function diagnostics()
  if not vim.diagnostic.is_enabled({ bufnr = 0 }) then
    return ""
  end

  local buffer_diagnostic = vim.diagnostic.count(0)
  if not buffer_diagnostic or vim.tbl_isempty(buffer_diagnostic) then
    return ""
  end

  local result = {}
  local severity = vim.diagnostic.severity

  local severity_map = {
    [severity.ERROR] = { group = "DiagnosticError", icon = icon.diagnostics.Error },
    [severity.WARN] = { group = "DiagnosticWarn", icon = icon.diagnostics.Warning },
    [severity.HINT] = { group = "DiagnosticHint", icon = icon.diagnostics.Hint },
    [severity.INFO] = { group = "DiagnosticInfo", icon = icon.diagnostics.Information },
  }
  for sev, data in pairs(severity_map) do
    local count = buffer_diagnostic[sev]
    if count and count > 0 then
      result[#result + 1] = string.format("%%#%s#%s %d", data.group, data.icon, count)
    end
  end

  return table.concat(result, " ")
end

local function filetype()
  local buf = vim.api.nvim_buf_get_name(0)
  local name, ext = vim.fn.fnamemodify(buf, ":t"), vim.fn.fnamemodify(buf, ":e")
  local ftype = vim.bo.filetype

  local icon_data = devicon(name, ext)
  local file_icon = icon_data and icon_data.icon or ""
  local hl = icon_data and icon_data.highlight or "Comment"

  return string.format("%%#%s#%s %s", hl, file_icon, ftype:upper())
end

local function lineinfo()
  return "%#Define#%P %l:%c"
end

-- local function scrollbar()
--   local current_line = vim.api.nvim_win_get_cursor(0)[1]
--   local total_line = vim.api.nvim_buf_line_count(0)
--   local i = math.floor((current_line - 1) / total_line * #icon.line_bar) + 1 -- i value ranges from 1 to length of line_bar
--   return string.format("%s", icon.line_bar[i])
-- end

local function searchcount()
  -- if vim.v.hlsearch > 0 then
  --   local result = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
  --   local denominator = math.min(result.total or 0, result.maxcount or 0)
  --   return string.format("%%#Type#%s [%d/%d]", icon.ui.Search, result.current, denominator)
  -- end

  if vim.v.hlsearch == 0 then
    return ""
  end

  local result = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
  local current = result.current or 0
  local total = math.min(result.total or 0, result.maxcount or 999)

  return string.format("%%#Type#%s [%d/%d]", icon.ui.Search, current, total)
end

local function plugin_updates()
  local lazy_info = require("lazy.status")
  return lazy_info.has_updates() and "%#Boolean#" .. lazy_info.updates() or ""
end

local progress_status = {
  client = nil,
  kind = nil,
  title = nil,
  percentage = nil,
}

local function lsp_progress_component()
  vim.api.nvim_create_autocmd("LspProgress", {
    group = vim.api.nvim_create_augroup("lsp-progress/statusline", { clear = true }),
    desc = "Update LSP progress in statusline",
    pattern = { "begin", "end", "report" },
    callback = function(args)
      if not args.data then
        return
      end

      progress_status = {
        client = vim.lsp.get_client_by_id(args.data.client_id).name,
        kind = args.data.params.value.kind,
        title = args.data.params.value.title,
        percentage = args.data.params.value.percentage or "",
      }

      if progress_status.kind == "end" then
        progress_status.title = nil
        vim.defer_fn(function()
          vim.cmd.redrawstatus()
        end, 1000)
      else
        vim.cmd.redrawstatus()
      end
    end,
  })

  if not progress_status.client or not progress_status.title then
    return ""
  end
  return table.concat({
    string.format(
      "%%#Conditional#%s [%s]",
      -- progress_status.client,
      progress_status.title,
      progress_status.percentage .. "%%"
    ),
  })
end

local function active()
  local parts
  local winwidth = vim.api.nvim_win_get_width(0)
  if winwidth >= 90 then
    parts = {
      mode(),
      filename(),
      diagnostics(),
      "%=",
      lsp(),
      lsp_progress_component(),
      "%=",
      git(),
      filetype(),
      lineinfo(),
      searchcount(),
      plugin_updates(),
    }
  else
    parts = {
      mode(),
      diagnostics(),
      "%=",
      -- searchcount(),
      lineinfo(),
    }
  end
  return table.concat(
    vim.tbl_filter(function(val)
      return not is_empty(val)
    end, parts),
    " "
  )
end

local function inactive()
  return "%#Normal#"
end

function Statusline.draw()
  local buffer_type = vim.bo.filetype
  return is_match(disable_statusline, buffer_type) and inactive() or active()
end

return Statusline
