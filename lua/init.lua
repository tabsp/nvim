local global = require 'global'
local options = require 'options'
local mapping = require 'mapping'
local dein = require 'dein'
local vim = vim
local M = {}

function M.createDir()
  local dataDir = {
    global.cacheDir..'undo'
  }
  if not global.isDir(global.cacheDir) then
    os.execute("mkdir -p " .. global.cacheDir)
    for _,v in pairs(dataDir) do
      if not global.isDir(v) then
        os.execute("mkdir -p " .. v)
      end
    end
  end
end

function M.loadInit()
  M.createDir()
  options.loadOptions()
  mapping.loadMapping()
  local d = dein:new()
  d:loadRepos()
  -- set theme
  vim.api.nvim_command("colorscheme onedark")
end

M.loadInit()
