<h1 dir="auto" align="center">📝 Orcnvim</h1>

<p align="center">
    <a href="https://www.neovim.io"><img alt="Neovim" src="https://img.shields.io/static/v1?label=Neovim&message=nightly&color=brightgreen&style=for-the-badge&logo=neovim" style="max-width:100%"></a>
    <a href="https://www.lua.org/"><img alt="Lua" src="https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua" style="max-width:100%"></a>
    <a href="https://www.gnu.org/licenses/gpl-3.0.en.html" rel="nofollow"><img alt="GPLv3" src="https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge" style="max-width: 100%;"></a>
</p>
<p align="center">
    <a href="https://github.com/zootedb0t/orcnvim/actions/workflows/luacheck.yml"><img alt="Luacheck" src="https://github.com/zootedb0t/orcnvim/actions/workflows/luacheck.yml/badge.svg" style="max-width:100%"></a>
</p>

![Screenshot_2023-05-17-02-03-52_](https://github.com/zootedb0t/orcnvim/assets/62596687/9d14cec5-4d3a-4684-9006-e30e02871473)

![Screenshot_2023-05-02-12-02-38_](https://user-images.githubusercontent.com/62596687/235631968-191dcd01-aaa8-4063-9bc4-235436d68fa6.png)

## :golf: Requirements

- Latest [neovim 0.10+](https://github.com/neovim/neovim). I use `neovim-nightly` built from [source](https://github.com/neovim/neovim/wiki/Building-Neovim).
- `Node` for installing lsp-servers.
- `Deno` for [peek.nvim](https://github.com/toppair/peek.nvim).
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/) for icons.
- [mason.nvim](https://github.com/williamboman/mason.nvim) has several requirements for installing `lsp servers` like `npm`, `cargo` etc. Check full list [here](https://github.com/williamboman/mason.nvim#requirements).
- [Tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/tree/master/cli) install it using `npm` or `cargo`.
- Clipboard tools like `xclip` or `wl-clipboard` for integration with system clipboard.
- `fd` and `ripgrep` for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).

## :pushpin: Installation

Make sure to remove or move the current `nvim` directory present in `.config`.

```sh
git clone --depth 1 https://github.com/zootedb0t/orcnvim.git ~/.config/nvim
```

If you are using `nvim-0.10+` then you can use `NVIM_APPNAME`.

```sh
git clone --depth 1 https://github.com/zootedb0t/orcnvim.git ~/.config/orcnvim
```

Now set environment variable `$NVIM_APPNAME=orcnvim`. Start `neovim` now `orcnvim` configration will be used.

## :scroll: Features

- Support `neovim` built-in `lsp`.
- Lazy load plugins for faster startup time. Thanks to [lazy.nvim](https://github.com/folke/lazy.nvim/)
- Custom `Statuscolumn`, `Winbar` and `Statusline`.
- Autocompletion using [cmp](https://github.com/hrsh7th/nvim-cmp).
- Syntax highlighting using [tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter).
- Support [Formatting](https://github.com/stevearc/conform.nvim) and [linting](https://github.com/nvimtools/none-ls.nvim).

# :clap: Credits

Sincere appreciation to the following repositories and the entire neovim community out there.

- [LunarVim](https://github.com/LunarVim/LunarVim/)
- [AstroVim](https://github.com/AstroNvim/AstroNvim)
