# My neovim setup

![snapshoot](snapshoot.jpg)

## Requirements

[Neovim Nightly (0.5)](https://github.com/neovim/neovim/releases/tag/nightly)

## Setup

### Clone

```shell
cd ~/.config && git clone https://github.com/tabsp/nvim.git
```
## pynvim

### Install pyenv

macOS:

```shell
brew install pyenv
brew install pyenv-virtualenv
```

The automatic installer:

```shell
curl https://pyenv.run | bash
```

```shell
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc

echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

exec "$SHELL"
```

### Install pynvim

```shell
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

## Optional

### bat

[source](https://github.com/sharkdp/bat)

```shell
brew install bat
```

### ripgrep

[source](https://github.com/BurntSushi/ripgrep)

```shell
brew install ripgrep
```

### Clipboard

#### Arch

```shell
pacman -S xsel
```

