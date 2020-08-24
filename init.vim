" ====================
" ==== 自动初始化 ====
" ====================
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ====================
" === 编辑界面配置 ===
" ====================
"""
""" 基础配置
"""
" 代码高亮
syntax on
" 显示行号
set number
" 显示相对行号
set relativenumber
" 当前行
set cursorline
" 超出长度后自动换行
set wrap
" 显示当前命令
set showcmd
" 命令补全
set wildmenu
set encoding=UTF-8
set guifont=Hack\ Nerd\ Font:h16
" 自动切换工作目录
set autochdir
" 行号样式
highlight LineNr ctermfg=white ctermbg=black
" 共享系统剪切板
set clipboard^=unnamed,unnamedplus

" 回到上次浏览的位置
autocmd BufReadPost *
            \ if ! exists("g:leave_my_cursor_position_alone") |
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \ exe "normal g'\"" |
            \ endif |
            \ endif

" 关闭备份并设置备份文件夹
set nobackup
set noswapfile
set undofile
set undodir=~/.config/nvim/undodir
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p', 0700)
endif

"""
""" 搜索
"""
" 搜索关键词高亮
set hlsearch
" 实时搜索
set incsearch
" 忽略大小写
set ignorecase
" 智能大小写
set smartcase
" 启动时清除高亮
exec "nohlsearch"

"""
""" 缩进
"""
" tab 占用空格数
set tabstop=4
" 每次退格将删除空格数
set softtabstop=4
" 每层缩进的空格数
set shiftwidth=4
" 自动展开 tab
set expandtab
" 回车后自动缩进
set autoindent
" set list
" set listchars=tab:>-,trail:-
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽

" ====================
" ==== 快捷键配置 ====
" ====================

" 将 <Space> 设置为 <LEADER>
let mapleader=" "
" 打开 nvim 配置文件
map <LEADER>rc :e $MYVIMRC<CR>
" 清除高亮
noremap <LEADER><CR> :nohlsearch<CR>
" 重新加载配置文件
noremap R :source $MYVIMRC<CR>

"""
""" buffer 操作
"""
" 保存文件
noremap S :w<CR>
" 关闭文件
noremap Q :q<CR>
noremap <C-d> :bdelete<CR>

"""
""" 光标移动
"""
noremap J 5j
noremap K 5k
noremap H 0
noremap L $
inoremap <C-A> <ESC>I
noremap W 5w
noremap B 5b

"""
""" 分屏操作
"""
" 向上下左右分屏
noremap sk :set nosplitbelow<CR>:split<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>
noremap sl :set splitright<CR>:vsplit<CR>
" 将光标移动至上下左右屏幕
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l


" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" 运行
noremap r :call Run()<CR>
func! Run()
    exec "w"
    if &filetype == 'html'
        silent! exec "!open % &"
    elseif &filetype == 'markdown'
        :InstantMarkdownPreview
    elseif &filetype == 'go'
        set splitbelow
        :sp
        :term go run .
    endif
endfunc

" ====================
" ===== 插件配置 =====
" ====================
call plug#begin('~/.config/nvim/plugged')
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" NERDTreeCommenter
Plug 'preservim/nerdcommenter'

" 文件搜索 fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'Chiel92/vim-autoformat'

" 自动配对
Plug 'jiangmiao/auto-pairs'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Nerd Font icon
Plug 'ryanoasis/vim-devicons'

" 屏保 :Matrix
Plug 'uguu-org/vim-matrix-screensaver'

" theme
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'

" 启动页面
Plug 'mhinz/vim-startify'

" 书签
Plug 'MattesGroeger/vim-bookmarks'

" tab line
Plug 'mg979/vim-xtabline'

" 标示根目录
Plug 'airblade/vim-rooter'

" 环绕字符编辑
Plug 'tpope/vim-surround'

" 方法列表
Plug 'majutsushi/tagbar'

call plug#end()

"""
""" airline
"""
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_theme='sol'
let g:airline#extensions#branch#enabled = 1

"""
""" coc
"""
source ~/.config/nvim/coc.vim

"""
""" NERDCommenter
"""
" 注释符与语句之间留一个空格
let NERDSpaceDelims=1
map -- <Plug>NERDCommenterToggle

"""
""" fzf
"""
map <C-f> :Files<CR>
map <C-o> :GFiles<CR>
map <C-b> :Buffers<CR>
" 让输入上方，搜索列表在下方
let $FZF_DEFAULT_OPTS = '--layout=reverse'
" 打开 fzf 的方式选择 floating window
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

function! OpenFloatingWin()
    let height = &lines - 3
    let width = float2nr(&columns - (&columns * 2 / 10))
    let col = float2nr((&columns - width) / 2)

    " 设置浮动窗口打开的位置，大小等。
    " 这里的大小配置可能不是那么的 flexible 有继续改进的空间
    let opts = {
                \ 'relative': 'editor',
                \ 'row': height * 0.3,
                \ 'col': col + 30,
                \ 'width': width * 2 / 3,
                \ 'height': height / 2
                \ }

    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)

    " 设置浮动窗口高亮
    call setwinvar(win, '&winhl', 'Normal:Pmenu')

    setlocal
                \ buftype=nofile
                \ nobuflisted
                \ bufhidden=hide
                \ nonumber
                \ norelativenumber
                \ signcolumn=no
endfunction

" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"""
""" LazyGit
"""
noremap <LEADER>lg :term lazygit<CR>

"""
""" markdown
"""
let g:instant_markdown_autostart = 0
noremap <LEADER>mp :InstantMarkdownPreview<CR>
let g:instant_markdown_autoscroll = 1
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'

" https://github.com/dhruvasagar/vim-table-mode
function! s:isAtStartOfLine(mapping)
    let text_before_cursor = getline('.')[0 : col('.')-1]
    let mapping_pattern = '\V' . escape(a:mapping, '\')
    let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
    return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

noremap <LEADER>tm :TableModeToggle<CR>
inoreabbrev <expr> <bar><bar>
            \ <SID>isAtStartOfLine('\|\|') ?
            \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
            \ <SID>isAtStartOfLine('__') ?
            \ '<c-o>:silent! TableModeDisable<cr>' : '__'

"""
""" GitGutter
"""
" 显示行号
set signcolumn=yes
" Colors
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=4

"""
""" xtabline
"""
let g:xtabline_settings = {}
let g:xtabline_settings.tabline_modes = ['buffers', 'tabs']
let g:xtabline_settings.theme = 'dracula'
noremap <LEADER>] :XTabNextBuffer<CR>
noremap <LEADER>[ :XTabPrevBuffer<CR>
noremap <LEADER>q :XTabCloseBuffer<CR>
noremap tl :XTabMoveBufferNext<CR>
noremap th :XTabMoveBufferPrev<CR>
noremap tp :XTabPinBuffer<CR>

"""
""" autoformat
"""
" au BufWrite *.go :Autoformat

" 主题配置
colorscheme onedark

"""
""" tagbar
"""
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }
let g:tagbar_width=50
nnoremap <silent> <C-t> :TagbarToggle<CR>
