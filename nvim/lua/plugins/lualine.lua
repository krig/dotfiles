-- get project-relative path of buffer
local function relpath()
  local bufname = vim.api.nvim_buf_get_name(0)

  local name = string.gsub(bufname, vim.loop.cwd(), '@')
  if name:sub(1, #'@') == '@' then
    return name
  end
  name = string.gsub(bufname, vim.env.HOME, '~')
  if name ~= '' then
    return name
  end
  name = vim.fn.expand('%')
  if name ~= '' then
    return name
  end
  return '[no name]'
end

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        theme = "auto",
        globalstatus = true,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = { { 'mode', fmt = string.lower } },
        lualine_b = {'searchcount', 'selectioncount'},
        lualine_c = { relpath },
        lualine_x = {},
        lualine_y = {'diagnostics'},
        lualine_z = { { 'branch', color = { fg = '#949cbb', bg = '#292c3c' } } }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
    },
  },
}
