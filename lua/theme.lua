local global = require 'global'
local vim,api = vim,vim.api
local theme = {}
local themeCache = global.cacheDir..'theme.txt'

function theme.loadTheme()
  local defaultTheme = 'oceanic_material'
  if vim.g.colors_name == nil then
    api.nvim_set_option('background','dark')
    local scheme = vim.fn.filereadable(themeCache) and defaultTheme or vim.fn.readfile(themeCache)[1]
    api.nvim_command("colorscheme "..scheme)
  end
  api.nvim_command("augroup LoadTheme")
  api.nvim_command("au!")
  api.nvim_command("autocmd ColorScheme * lua require'theme'.write_to_file()")
  api.nvim_command("autocmd ColorSchemePre * lua require'theme'.cleanup_theme()")
  api.nvim_command("augroup END")
end

function theme.writeToFile()
  if vim.g.colors_name ~= nil then
    vim.fn.writefile({vim.g.colors_name},themeCache)
  end
end

function theme.cleanupTheme()
  if vim.g.colors_name ~= nil then
    return
  end
  vim.api.nvim_command("highlight clear")
end

return theme
