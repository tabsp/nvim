local global = require "global"
local options = require "options"
local mapping = require "mapping"
local dein = require "dein"
local autocmd = require "autocmd"
local colors = require "colors"
local vim = vim
local M = {}

function M.createDir()
  local dataDir = {
    global.cacheDir .. "undo"
  }
  if not global.isDir(global.cacheDir) then
    os.execute("mkdir -p " .. global.cacheDir)
    for _, v in pairs(dataDir) do
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
  autocmd.loadAutocmds()
  colors.loadColorscheme()
  -- statusline
  require "statusline"
end

M.loadInit()
