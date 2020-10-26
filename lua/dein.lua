local global = require 'global'
local vim = vim
local dein  = {}

function dein:new()
  local instance = {}
  setmetatable(instance,self)
  self.__index = self
  self.repos = {}
  self.configFiles = {}
  return instance
end

function dein:parseConfig()
  local cmd = nil
  if global.isMac then
    cmd = [[ruby -e 'require "json"; require "yaml"; print JSON.generate YAML.load $stdin.read']]
  elseif global.isLinux then
    cmd = [[python -c 'import sys,yaml,json; y=yaml.safe_load(sys.stdin.read()); print(json.dumps(y))']]
  end
  local p = io.popen('find "'..global.modulesDir..'" -name "*.yaml"')
  for file in p:lines() do
    table.insert(self.configFiles,vim.inspect(file))
    local cfg = vim.api.nvim_eval(vim.fn.system(cmd, global.readAll(file)))
    for _,v in pairs(cfg) do
      table.insert(self.repos,v)
    end
  end
  table.insert(self.configFiles,vim.fn.expand("<sfile>"))
end

function dein:loadRepos()
  local deinPath = global.cacheDir .. 'dein'
  local deinDir = global.cacheDir ..'dein/repos/github.com/Shougo/dein.vim'
  local cmd = "git clone https://github.com/Shougo/dein.vim " .. deinDir

  if vim.fn.has('vim_starting') then
    vim.api.nvim_set_var('dein#auto_recache',1)
    vim.api.nvim_set_var('dein#install_max_processes',12)
    vim.api.nvim_set_var('dein#install_progress_type',"title")
    vim.api.nvim_set_var('dein#enable_notification',1)
    vim.api.nvim_set_var('dein#install_log_filename',global.cacheDir ..'dein.log')

    if not vim.o.runtimepath:match('/dein.vim') then
      if not global.isDir(deinDir) then
        os.execute(cmd)
      end
      vim.o.runtimepath = vim.o.runtimepath ..','..deinDir
    end
  end

  if vim.fn['dein#load_state'](deinPath) == 1 then
    self:parseConfig()
    vim.fn['dein#begin'](deinPath,self.configFiles)
    for _,cfg in pairs(self.repos) do
      vim.fn['dein#add'](cfg.repo,cfg)
    end
    vim.fn['dein#end']()
    vim.fn['dein#save_state']()

    if vim.fn['dein#check_install']() == 1 then
      vim.fn['dein#install']()
    end
  end

  vim.api.nvim_command('filetype plugin indent on')

  if vim.fn.has('vim_starting') == 1 then
    vim.api.nvim_command('syntax enable')
  end

  vim.fn['dein#call_hook']('source')
  vim.fn['dein#call_hook']('post_source')
end

return dein
