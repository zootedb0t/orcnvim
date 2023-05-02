# orcnvim [![](https://img.shields.io/static/v1?label=Neovim&message=0.10&color=brightgreen&style=flat&logo=neovim)](https://github.com/neovim/neovim) ![](https://img.shields.io/badge/Lua-blue.svg?style=flat&logo=lua) 

My neovim config.

![Screenshot_2023-05-02-12-02-38_](https://user-images.githubusercontent.com/62596687/235631968-191dcd01-aaa8-4063-9bc4-235436d68fa6.png)

## Requirements

- Latest [neovim 0.10+](https://github.com/neovim/neovim). I use `neovim-nightly` built from [source](https://github.com/neovim/neovim/wiki/Building-Neovim).
- `Deno` for [peek.nvim](https://github.com/toppair/peek.nvim).
- [ripgrep](https://github.com/BurntSushi/ripgrep).
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/) (for icons).
- [mason.nvim](https://github.com/williamboman/mason.nvim) has several requirements for installing `lsp servers` like `npm`, `cargo` etc. Check full list [here](https://github.com/williamboman/mason.nvim#requirements).
- [Tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/tree/master/cli) install it using `npm` or `cargo`.
- Clipboard tools like `xclip` for integration with system clipboard.

## Installation

Make sure to remove or move the current `nvim` directory present in `.config`.
```sh
git clone --depth 1 https://github.com/zootedb0t/orcnvim.git ~/.config/nvim
```

If you are using `nvim-0.9+` then you can use `NVIM_APPNAME`.
```sh
git clone --depth 1 https://github.com/zootedb0t/orcnvim.git ~/.config/orcnvim
```
Now set environment variable `$NVIM_APPNAME=orcnvim`. Start `neovim` now `orcnvim` configration will be used.

## Features
- Lazy load plugins for faster startup time. Thanks to [lazy.nvim](https://github.com/folke/lazy.nvim/)
- Custom `statusline` and `winbar`.
- Autocompletion using [cmp](https://github.com/hrsh7th/nvim-cmp).
- Syntax highlighting using [tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter).
- Formatting and linting using [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim).

# Credits

Sincere appreciation to the following repositories and the entire neovim community out there.

- [LunarVim](https://github.com/LunarVim/LunarVim/)
- [AstroVim](https://github.com/AstroNvim/AstroNvim)
