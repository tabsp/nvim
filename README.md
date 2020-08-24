# My neovim setup

## 使用方法

### clone

```bash
cd ~/.config && git clone https://github.com/tabsp/nvim.git
```

### 依赖

#### node

```shell
# MacOS
brew install node

# Arch
sudo pacman -S nodejs npm
```

#### ctags

```shell
# MacOS
brew install ctags

# Arch
sudo pacman -S ctags

# gotags
go get -u github.com/jstemmer/gotags
```

#### Ag

```shell
# MacOS
brew install the_silver_searcher

# Arch
sudo pacman -S the_silver_searcher
```

####  Nerd Fonts

用于各种图标

字体预览：[https://www.programmingfonts.org/](https://www.programmingfonts.org/)

eg:

```shell
# MacOS
brew tap homebrew/cask-fonts && brew cask install font-hack-nerd-font

# Arch
yay -S nerd-fonts-meslo
```

#### 安装 instant-markdown-d

用于预览 Markdown

```shell
npm -g install instant-markdown-d --registry=https://registry.npm.taobao.org
```

#### 其它

- [lazygit](https://github.com/jesseduffield/lazygit)
- [fzf](https://github.com/junegunn/fzf)
- [ranger](https://github.com/ranger/ranger)

### Language Server

#### ccls

[ccls](https://github.com/MaskRay/ccls) 用于开发 C/C++

```shell
# MacOS
brew update
brew install ccls

# Arch
sudo pacman -S ccls
```

#### jdt.ls

用于开发 Java

[jdt.ls](https://github.com/eclipse/eclipse.jdt.ls) 依赖于 JDK 11，安装 JDK 11 后配置 coc-settings.json 中的 `java.home`

使用 vim 打开任意 `.java` 文件会自动安装 jdt.ls，安装时间会比较久。

