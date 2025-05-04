<h1 dir="auto" align="center">📝 Orcnvim</h1>

<p align="center">
    <a href="https://www.neovim.io"><img alt="Neovim" src="https://img.shields.io/static/v1?label=Neovim&message=nightly&color=brightgreen&style=for-the-badge&logo=neovim" style="max-width:100%"></a>
    <a href="https://www.lua.org/"><img alt="Lua" src="https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua" style="max-width:100%"></a>
    <a href="https://www.gnu.org/licenses/gpl-3.0.en.html" rel="nofollow"><img alt="GPLv3" src="https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge" style="max-width: 100%;"></a>
</p>
<p align="center">
    <a href="https://github.com/zootedb0t/orcnvim/actions/workflows/luacheck.yml"><img alt="Luacheck" src="https://github.com/zootedb0t/orcnvim/actions/workflows/luacheck.yml/badge.svg" style="max-width:100%"></a>
</p>

![Screenshot_2023-12-01-11-12-55](https://github.com/zootedb0t/orcnvim/assets/62596687/87364748-4b8d-425a-8f5a-7d3484e60197)

![Screenshot_2023-11-09-07-13-41_1920x1080](https://github.com/zootedb0t/orcnvim/assets/62596687/481a9128-a540-428e-b083-725f21c4f4f2)

![Screenshot_2023-12-01-11-07-07](https://github.com/zootedb0t/orcnvim/assets/62596687/4f9ea0fa-bf0e-46fc-9c17-250c3bf7ee5e)

## :golf: Requirements

- Latest [neovim-nightly](https://github.com/neovim/neovim/wiki/Building-Neovim).
- `Node` for installing lsp-servers.
- `deno` for [peek.nvim](https://github.com/toppair/peek.nvim).
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

Now set environment variable `$NVIM_APPNAME=orcnvim`. Start `neovim` now `orcnvim` configuration will be used.

## :scroll: Features

- Support `neovim` built-in lsp.
- Lazy load plugins for faster startup time. Thanks to [lazy.nvim](https://github.com/folke/lazy.nvim/)
- Custom `Statuscolumn`, `Winbar` and `Statusline`.
- Autocompletion using [blink.cmp](https://github.com/Saghen/blink.cmp).
- Syntax highlighting using [tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter).
- Support [Formatting](https://github.com/stevearc/conform.nvim) and [Linting](https://github.com/nvimtools/none-ls.nvim).

# :clap: Credits

Sincere appreciation to the following repositories and the entire neovim community out there.

- [LunarVim](https://github.com/LunarVim/LunarVim/)
- [AstroVim](https://github.com/AstroNvim/AstroNvim)
