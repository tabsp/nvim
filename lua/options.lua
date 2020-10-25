local global = require 'global'
local vim = vim
local options = {}

function options:new()
  local instance = {}
  setmetatable(instance,self)
  self.__index = self
  return instance
end

function options:loadOptions()
  -- editor options
  vim.o.clipboard = 'unnamed,unnamedplus'
  vim.o.encoding = 'utf-8'
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.swapfile = false
  vim.o.undofile = true
  vim .o.undodir = global.cacheDir .. "undo/"

  -- window-scoped local-options
  vim.wo.number = true
  vim.wo.relativenumber = true
  vim.wo.cursorline = true

  -- buffer-scoped local-options
end

return options
