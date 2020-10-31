local colors = {
  yellow = "#ffff00",
  blue = "#51afef",
  linebg = "#383E4A",
  none = "NONE"
}

function colors.loadSyntax()
  local syntax = {
    CursorLineNr = {fg = colors.yellow},
    CursorLine = {bg = colors.linebg}
  }
  return syntax
end

function colors.highlight(group, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  vim.api.nvim_command("highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg)
end

function colors.loadColorscheme()
  vim.api.nvim_command("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.api.nvim_command("syntax reset")
  end
  vim.g.colors_name = "onedark"
  vim.o.background = "dark"
  vim.o.termguicolors = true

  for group, color in pairs(colors.loadSyntax()) do
    colors.highlight(group, color)
  end
end

return colors
