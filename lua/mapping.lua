local M = {}
local vim = vim
local mapping = {}
local rhsOptions = {}

function mapping:new()
  local instance = {}
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function mapping:loadVimDefine()
  vim.g.mapleader = " "
  self.vim= {
    ['|<LEADER>rc'] = mapCu('e $MYVIMRC'):withNoremap(),
    ['|R'] = mapCu('source $MYVIMRC'):withNoremap(),
    ['|<LEADER><CR>'] = mapCr('nohls'):withNoremap(),
    ['i|jj'] = mapCmd('<ESC>'):withNoremap(),
    -- buffer
    ['|S'] = mapCu('write'):withNoremap(),
    ['|Q'] = mapCu('quit'):withNoremap(),
    ['|<C-d>'] = mapCu('bdelete'):withNoremap(),
    -- cursor
    ['|J'] = mapCmd('5j'):withNoremap(),
    ['|K'] = mapCmd('5k'):withNoremap(),
    ['|H'] = mapCmd('0'):withNoremap(),
    ['|L'] = mapCmd('$'):withNoremap(),
    ['|W'] = mapCmd('5w'):withNoremap(),
    ['|B'] = mapCmd('5b'):withNoremap(),
    ['i|<C-a>'] = mapCmd('<ESC>I'):withNoremap(),
    ['i|<C-e>'] = mapCmd('<ESC>A'):withNoremap(),
    -- split window
    ['|sk'] = mapCr('set nosplitbelow<CR>:split'):withNoremap(),
    ['|sj'] = mapCr('set splitbelow<CR>:split'):withNoremap(),
    ['|sh'] = mapCr('set nosplitright<CR>:vsplit'):withNoremap(),
    ['|sl'] = mapCr('set splitright<CR>:vsplit'):withNoremap(),
    ['|<C-k>'] = mapCmd('<C-w>k'):withNoremap(),
    ['|<C-j>'] = mapCmd('<C-w>j'):withNoremap(),
    ['|<C-h>'] = mapCmd('<C-w>h'):withNoremap(),
    ['|<C-l>'] = mapCmd('<C-w>l'):withNoremap(),
  }
end

function mapping:loadPluginDefine()
  self.plugin = {
    ["n|tt"] = mapCu('LuaTreeToggle'):withNoremap():withSilent(),
  }
end

function M.nvimLoadMapping(mapping)
  for _,v in pairs(mapping) do
    for key,value in pairs(v) do
      local mode,keymap = key:match('([^|]*)|?(.*)')
      if type(value) == 'table' then
        local rhs = value.cmd
        local options = value.options
        vim.fn.nvim_set_keymap(mode,keymap,rhs,options)
      end
    end
  end
end

function rhsOptions:new()
  local instance = {
    cmd = '',
    options = {
      noremap = false,
      silent = false,
      expr = false,
    }
  }
  setmetatable(instance,self)
  self.__index = self
  return instance
end

function rhsOptions:mapCmd(cmd)
  self.cmd = cmd
  return self
end

function rhsOptions:mapCr(cmd)
  self.cmd = (':%s<CR>'):format(cmd)
  return self
end

function rhsOptions:mapCu(cmd)
  self.cmd = (':<C-u>%s<CR>'):format(cmd)
  return self
end

function rhsOptions:withSilent()
  self.options.silent = true
  return self
end

function rhsOptions:withNoremap()
  self.options.noremap = true
  return self
end

function rhsOptions:withExpr()
  self.options.expr = true
  return self
end

function mapCr(cmd)
  local ro = rhsOptions:new()
  return ro:mapCr(cmd)
end

function mapCmd(cmd)
  local ro = rhsOptions:new()
  return ro:mapCmd(cmd)
end

function mapCu(cmd)
  local ro = rhsOptions:new()
  return ro:mapCu(cmd)
end


function M.loadMapping()
  local map = mapping:new()
  map:loadVimDefine()
  map:loadPluginDefine()
  M.nvimLoadMapping(map)
end

return M
