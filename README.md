# orcnvim

My neovim config.

> Transparency ON
> ![Screenshot_2023-02-05-05-15-51_1920x1080](https://user-images.githubusercontent.com/62596687/216817008-491c5081-eb81-4b6d-99eb-bffe7980698c.png)

> Transparency OFF
> ![Screenshot_2023-02-05-05-09-57_1920x1080](https://user-images.githubusercontent.com/62596687/216817045-e739774a-ce26-4841-9089-3bfc155d169d.png)

## Requirements

- Latest [neovim 0.9+](https://github.com/neovim/neovim). I use `neovim-nightly` built from [source](https://github.com/neovim/neovim/wiki/Building-Neovim).
- `Deno` for [peek.nvim](https://github.com/toppair/peek.nvim).
- [ripgrep](https://github.com/BurntSushi/ripgrep).
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/) (for icons).
- [mason.nvim](https://github.com/williamboman/mason.nvim) has several requirements for installing `lsp servers` like `npm`, `cargo` etc. Check full list [here](https://github.com/williamboman/mason.nvim#requirements).
- [Tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/tree/master/cli) install it using `npm` or `cargo`.
- Clipboard tools like `xclip` for integration with system clipboard.

## Installation

Make sure to remove or move the current `nvim` directory present in `.config`.

```sh
git clone https://github.com/zootedb0t/orcnvim.git ~/.config/nvim
```

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
