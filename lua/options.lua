local global = require "global"
local vim = vim
local options = {}
local M = {}

function options:new()
  local instance = {}
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function M.nvimLoadOptions(options)
  for k, v in pairs(options) do
    for key, value in pairs(v) do
      vim[k][key] = value
    end
  end
end

-- editor options
function options:loadEditorDefine()
  self.o = {
    clipboard = "unnamed,unnamedplus",
    encoding = "utf-8",
    ignorecase = true,
    smartcase = true,
    swapfile = false,
    undofile = true,
    undodir = global.cacheDir .. "undo/",
    termguicolors = true,
    listchars = "tab:»·,nbsp:+,trail:▫,extends:❯,precedes:❮",
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = false,
    autoindent = true,
    completeopt = "menuone,noinsert,noselect",
    shortmess = "aoOTIcF",
    mouse = "nv"
  }
end

-- window-scoped local-options
function options:loadWindowDefine()
  self.wo = {
    number = true,
    relativenumber = true,
    cursorline = true,
    list = true,
    numberwidth = 1,
    foldmethod = "indent"
  }
end

-- buffer-scoped local-options
function options:loadBufferDefine()
  self.bo = {
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = false
  }
end

function M.loadOptions()
  opts = options:new()
  opts:loadEditorDefine()
  opts:loadWindowDefine()
  opts:loadBufferDefine()
  M.nvimLoadOptions(opts)
  if global.isMac then
    vim.g.python_host_prog = "/usr/bin/python"
    vim.g.python3_host_prog = "/usr/local/bin/python3"
  end
end

return M
