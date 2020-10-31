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
pyenv virtualenv 2.7.15 py2nvim
pyenv activate py2nvim
pip install pynvim
pyenv deactivate

pyenv install 3.7.1
pyenv virtualenv 3.7.1 py3nvim
pyenv activate py3nvim
pip install pynvim
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
