# My neovim setup

Lua 重构版

## 使用方法

### clone

```shell
cd ~/.config && git clone https://github.com/tabsp/nvim.git
```
## pynvim

```shell
brew install pyenv
brew install pyenv-virtualenv

pyenv install 2.7.15
pyenv virtualenv 2.7.15 neovim2
pyenv activate neovim2
pip install neovim
pyenv deactivate

pyenv install 3.7.9
pyenv virtualenv 3.7.9 neovim3
pyenv activate neovim3
pip install neovim
pyenv deactivate
```

## Language server

### gopls

```shell
go get golang.org/x/tools/gopls@latest
```

### typescript-language-server

```shell
npm install -g typescript-language-server
```

## Formt Code

### lua-fmt

[source](https://github.com/trixnz/lua-fmt)

```shell
npm install -g lua-fmt
```
