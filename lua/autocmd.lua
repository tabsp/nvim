local vim = vim
local autocmd = {}

function autocmd.nvimCreateAugroups(definitions)
  for groupName, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. groupName)
    vim.api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command("augroup END")
  end
end

function autocmd.loadAutocmds()
  local definitions = {
    bufs = {
      -- Reload vim config automatically
      {"BufWritePost", [[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]]},
      -- Reload Vim script automatically if setlocal autoread
      {
        "BufWritePost,FileWritePost",
        "*.vim",
        [[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]]
      },
      {"BufWritePre", "/tmp/*", "setlocal noundofile"},
      {"BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile"},
      {"BufWritePre", "MERGE_MSG", "setlocal noundofile"},
      {"BufWritePre", "*.tmp", "setlocal noundofile"},
      {"BufWritePre", "*.bak", "setlocal noundofile"},
      {
        "BufReadPost",
        "*",
        [[nested if ! exists("g:leave_my_cursor_position_alone") | if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal g'\"" | endif | endif]]
      },
      -- Auto format
      {"BufWritePre", "*.lua", "lua vim.api.nvim_command('Format')"}
    },
    wins = {
      -- Highlight current line only on focused window
      {
        "WinEnter,BufEnter,InsertLeave",
        "*",
        [[if ! &cursorline && &filetype !~# '^\(denite\|clap_\)' && ! &pvw | setlocal cursorline | endif]]
      },
      {
        "WinLeave,BufLeave,InsertEnter",
        "*",
        [[if &cursorline && &filetype !~# '^\(denite\|clap_\)' && ! &pvw | setlocal nocursorline | endif]]
      },
      -- Equalize window dimensions when resizing vim window
      {"VimResized", "*", [[tabdo wincmd =]]},
      -- Force write shada on leaving nvim
      {"VimLeave", "*", [[if has('nvim') | wshada! | else | wviminfo! | endif]]},
      -- Check if file changed when its window is focus, more eager than 'autoread'
      {"FocusGained", "* checktime"}
    },
    ft = {
      {"FileType", "dashboard", "set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2"}
    },
    yank = {
      {"TextYankPost", [[* silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=400})]]}
    }
    -- gitblame = {
    --   {"CursorHold","*","lua require'version'.blameVirtualText()"};
    --   {"CursorMoved,CursorMovedI","*","lua require'version'.clearBlameVirtualText()"};
    -- }
  }

  autocmd.nvimCreateAugroups(definitions)
end

return autocmd
