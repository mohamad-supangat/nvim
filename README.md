# NeoVim As IDE with me

the main goal of this project is to make it easier for vscode users to migrate to neovim as a day-to-day IDE using best of neovim plugin https://github.com/neoclide/coc.nvim

![image.png](./screenshots/image.png)

## Install

- need to install git, nodejs, neovim, [pynvim](https://github.com/neovim/pynvim) > 0.5
- (optional) `c` compiler and `make` for compile better highlighting and language parser in neovim [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- just clone this repo

```bash
git clone https://github.com/mohamad-supangat/nvim.git ~/.config/nvim
```

- and run neovim, and viola

## Docs

### Shortcuts

Some of the shortcuts I use frequently are listed here. In the following shortcuts, `<leader>` represents ASCII character `,`.

| Shortcut                          | Mode   | Description                                                                         |
| --------------------------------- | ------ | ----------------------------------------------------------------------------------- |
| `<ctrl>p`                         | Normal | Fuzzy file searching in a floating window                                           |
| `<ctrl>n`                         | Normal | Open sidebar file explorer                                                          |
| `<ctrl>t`                         | Normal | New file                                                                            |
| `<ctrl>PageDown` / `<ctrl>PageUp` | Normal | Change tab to next and prev                                                         |
| `<space>bd`                       | Normal | Close Buffer / File                                                                 |
| `<alt>i` / `F1` / `F2`            | Normal | Toogle floating terminal                                                            |
| `<space>coc`                      | Normal | Open coc helpers list with FZF                                                      |
| `<space>P`                        | Normal | Open list of coc commands                                                           |
| `F8`                              | Normal | Toogle sidebar tags explorer                                                        |
| `<space>rr`                       | Normal | Run current file by [code_runner.nvim](https://github.com/CRAG666/code_runner.nvim) |
| `<space>git`                       | Normal | Run lazygit(install lazygit first) [code_runner.nvim](https://github.com/CRAG666/code_runner.nvim) |
