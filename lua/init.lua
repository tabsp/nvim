local global = require 'global'
local options = require 'options'
local mapping = require 'mapping'
local dein = require 'dein'
local theme = require 'theme'
local vim = vim
local M = {}

function M.createDir()
  local dataDir = {
    global.cacheDir..'undo'
  }
  -- There only check once that If cache_dir exists
  -- Then I don't want to check subs dir exists
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
  local opts = options:new()
  opts:loadOptions()

  local d = dein:new()
  d:loadRepos()

  mapping.loadMapping()

  theme.loadTheme()
end

M.loadInit()

