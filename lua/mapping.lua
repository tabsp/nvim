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
  self.vim = {
    ["n|<LEADER>rc"] = mapCu("e $MYVIMRC"):withNoremap(),
    ["n|R"] = mapCu("source $MYVIMRC"):withNoremap(),
    ["n|<LEADER><CR>"] = mapCr("nohls"):withNoremap(),
    ["i|jj"] = mapCmd("<ESC>"):withNoremap(),
    -- buffer
    ["n|S"] = mapCu("write"):withNoremap(),
    ["n|Q"] = mapCu("quit"):withNoremap(),
    ["n|<C-d>"] = mapCu("Bdelete"):withNoremap(),
    ["n|<LEADER>="] = mapCu("bnext"):withNoremap(),
    ["n|<LEADER>-"] = mapCu("bprevious"):withNoremap(),
    -- cursor
    ["n|J"] = mapCmd("5j"):withNoremap(),
    ["n|K"] = mapCmd("5k"):withNoremap(),
    ["n|H"] = mapCmd("^"):withNoremap(),
    ["n|L"] = mapCmd("$"):withNoremap(),
    ["n|W"] = mapCmd("5w"):withNoremap(),
    ["n|B"] = mapCmd("5b"):withNoremap(),
    ["i|<C-a>"] = mapCmd("<ESC>I"):withNoremap(),
    ["i|<C-e>"] = mapCmd("<ESC>A"):withNoremap(),
    ["c|<C-b>"] = mapCmd("<Left>"):withNoremap(),
    ["c|<C-f>"] = mapCmd("<Right>"):withNoremap(),
    ["c|<C-a>"] = mapCmd("<Home>"):withNoremap(),
    ["c|<C-e>"] = mapCmd("<End>"):withNoremap(),
    ["c|<C-d>"] = mapCmd("<Del>"):withNoremap(),
    -- split window
    ["n|sk"] = mapCr("set nosplitbelow<CR>:split"):withNoremap(),
    ["n|sj"] = mapCr("set splitbelow<CR>:split"):withNoremap(),
    ["n|sh"] = mapCr("set nosplitright<CR>:vsplit"):withNoremap(),
    ["n|sl"] = mapCr("set splitright<CR>:vsplit"):withNoremap(),
    ["n|<C-k>"] = mapCmd("<C-w>k"):withNoremap(),
    ["n|<C-j>"] = mapCmd("<C-w>j"):withNoremap(),
    ["n|<C-h>"] = mapCmd("<C-w>h"):withNoremap(),
    ["n|<C-l>"] = mapCmd("<C-w>l"):withNoremap(),
    -- Press space twice to jump to the next '<++>' and edit it
    ["n|<LEADER><LEADER>"] = mapCr("<ESC>/<++><CR>:nohlsearch"):withNoremap(),
    ["i|<C-k>"] = mapCmd("<ESC>ld$a"):withNoremap()
  }
end

function mapping:loadPluginDefine()
  self.plugin = {
    ["n|tt"] = mapCu("Defx"):withNoremap():withSilent(),
    ["n|<LEADER>bp"] = mapCu("BufferLinePick"):withNoremap():withSilent(),
    ["n|<Leader>pr"] = mapCr("call dein#recache_runtimepath()"):withNoremap():withSilent(),
    ["i|<TAB>"] = mapCmd([[pumvisible() ? '<C-n>' : '<Tab>']]):withExpr():withSilent(),
    ["i|<S-TAB>"] = mapCmd([[pumvisible() ? '<C-p>' : '<S-Tab>']]):withNoremap():withExpr(),
    -- neovim lsp
    ["n|gd"] = mapCmd("<cmd>lua vim.lsp.buf.definition()<CR>"):withNoremap():withSilent(),
    ["n|gi"] = mapCmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):withNoremap():withSilent(),
    ["n|gr"] = mapCmd("<cmd>lua vim.lsp.buf.references()<CR>"):withNoremap():withSilent(),
    ["n|gh"] = mapCmd("<cmd>lua vim.lsp.buf.hover()<CR>"):withNoremap():withSilent(),
    -- accelerated-jk
    ["n|j"] = mapCmd("<Plug>(accelerated_jk_gj)"):withSilent(),
    ["n|k"] = mapCmd("<Plug>(accelerated_jk_gk)"):withSilent(),
    -- thaerkh/vim-workspace
    ["n|<LEADER>s"] = mapCu("ToggleWorkspace"):withNoremap(),
    -- nvim-lua/telescope.nvim
    ["n|<LEADER>ff"] = mapCu("Telescope find_files"):withNoremap():withSilent(),
    ["n|<LEADER>fg"] = mapCu("Telescope git_files"):withNoremap():withSilent(),
    ["n|<LEADER>fb"] = mapCu("Telescope buffers show_all_buffers=true"):withNoremap():withSilent(),
    ["n|<LEADER>fs"] = mapCu("Telescope live_grep"):withNoremap():withSilent(),
    ["n|<LEADER>fh"] = mapCu("Telescope help_tags"):withNoremap():withSilent(),
    ["n|<LEADER>fc"] = mapCu("Telescope commands"):withNoremap():withSilent(),
    ["n|<LEADER>ft"] = mapCu("Telescope builtin"):withNoremap():withSilent()
  }
end

function M.nvimLoadMapping(mapping)
  for _, v in pairs(mapping) do
    for key, value in pairs(v) do
      local mode, keymap = key:match("([^|]*)|?(.*)")
      if type(value) == "table" then
        local rhs = value.cmd
        local options = value.options
        vim.fn.nvim_set_keymap(mode, keymap, rhs, options)
      end
    end
  end
end

function rhsOptions:new()
  local instance = {
    cmd = "",
    options = {
      noremap = false,
      silent = false,
      expr = false
    }
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function rhsOptions:mapCmd(cmd)
  self.cmd = cmd
  return self
end

function rhsOptions:mapCr(cmd)
  self.cmd = (":%s<CR>"):format(cmd)
  return self
end

function rhsOptions:mapCu(cmd)
  self.cmd = (":<C-u>%s<CR>"):format(cmd)
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
