# Neovim Command Cheatsheet

> **Leader key:** `,` (comma)

## Key Notation Guide

| Notation | Meaning | Example |
|----------|---------|---------|
| `<Leader>` | Leader key (comma for you) | `<Leader>s` = `,s` |
| `<C-x>` | Control + x | `<C-h>` = `Ctrl+h` |
| `<M-x>` | Meta/Alt + x | `<M-w>` = `Alt+w` |
| `<S-x>` | Shift + x | `<S-Tab>` = `Shift+Tab` |
| `<CR>` | Enter/Return key | |
| `<ESC>` | Escape key | |
| `<BS>` | Backspace key | |
| `<Tab>` | Tab key | |
| `<Space>` | Space bar | |

## General / File Operations

| Key | Name | Description |
|-----|------|-------------|
| `<Leader>s` | Save | Force save current file |
| `<Leader>q` | Quit | Force quit without saving |
| `<Leader>e` | File Explorer | Open Oil file explorer |
| `-` | Parent Directory | Open parent directory in Oil |
| `gx` | Open External | Open file/URL under cursor in browser |

## Navigation

| Key | Name | Description |
|-----|------|-------------|
| `j` / `k` | Visual Line Move | Move by visual lines (respects wrapped lines) |
| `<Up>` / `<Down>` | Visual Line Move | Arrow key visual line movement |
| `n` / `N` | Centered Search | Go to next/prev search match (centered) |
| `*` | Stay Star | Highlight word under cursor without jumping |
| `<C-h>` | Tmux Left | Navigate to left tmux pane/vim split |
| `<C-j>` | Tmux Down | Navigate to bottom tmux pane/vim split |
| `<C-k>` | Tmux Up | Navigate to top tmux pane/vim split |
| `<C-l>` | Tmux Right | Navigate to right tmux pane/vim split |
| `<C-\>` | Tmux Previous | Navigate to previous tmux pane |
| `<Leader>]` | Next Tab | Go to next tab |
| `<Leader>[` | Previous Tab | Go to previous tab |

## Search / Find (FZF)

| Key | Name | Description |
|-----|------|-------------|
| `<C-p>` | Git Files | Fuzzy find git-tracked files |
| `<C-b>` | All Files | Fuzzy find all files |
| `<C-g>` | Document Symbols | LSP document symbols picker |
| `<Leader>ff` | Files | Fuzzy find files |
| `<Leader>fg` | Live Grep | Search text across files |
| `<Leader>fb` | Buffers | List open buffers |
| `<Leader>fh` | Help Tags | Search help documentation |
| `<Leader>fp` | Old Files | Recently opened files |
| `<Leader>F` | FzfLua Files | Alternative files picker |
| `<Leader>gs` | Grep Word | Search word under cursor |
| `<Leader>gg` | Live Grep | Search text across files |
| `<Leader>ch` | Command History | Browse command history |
| `<Leader>td` | Diagnostics | Document diagnostics picker |

## Quickfix

| Key | Name | Description |
|-----|------|-------------|
| `<C-n>` | Next Quickfix | Go to next quickfix item (centered) |
| `<C-m>` | Prev Quickfix | Go to previous quickfix item (centered) |
| `<Leader>a` | Close Quickfix | Close the quickfix window |

## Editing

| Key | Name | Description |
|-----|------|-------------|
| `<Leader>rw` | Rename Word | Search/replace word under cursor globally |
| `p` (visual) | Paste Keep | Paste without replacing clipboard contents |
| `jj` / `jk` | Exit Insert | Quick escape to normal mode |
| `<C-c>` | ESC | Ctrl-C acts as ESC in insert mode |
| `<Leader><Space>` | Clear Highlight | Remove search highlighting |

## LSP (Language Server)

| Key | Name | Description |
|-----|------|-------------|
| `gd` | Go to Definition | Jump to definition |
| `gD` | Go to Declaration | Jump to declaration |
| `gT` | Go to Type | Jump to type definition |
| `gr` | References | Find all references |
| `gi` | Implementations | Find implementations |
| `K` | Hover | Show hover documentation |
| `<Leader>v` | Definition (vsplit) | Open definition in vertical split |
| `<Leader>h` | Definition (split) | Open definition in horizontal split |
| `<Leader>rn` | Rename | Rename symbol |
| `<Leader>ca` | Code Action | Show code actions |
| `<Leader>cl` | Code Lens | Run code lens |
| `<Leader>ih` | Toggle Inlay Hints | Toggle inlay hints on/off |

## Diagnostics (Trouble)

| Key | Name | Description |
|-----|------|-------------|
| `<Leader>xx` | Diagnostics | Toggle workspace diagnostics |
| `<Leader>xX` | Buffer Diagnostics | Toggle buffer-only diagnostics |
| `<Leader>xs` | Symbols | Toggle symbols outline |
| `<Leader>xq` | Quickfix List | Toggle quickfix in Trouble |

## Git

| Key | Name | Description |
|-----|------|-------------|
| `<Leader>gb` | Git Blame | Show blame for current line |
| `<Leader>go` | Git Open | Open current file in browser (GitHub) |
| `<Leader>gy` | Git Yank URL | Copy git URL to clipboard |

## Clipboard / Yank

| Key | Name | Description |
|-----|------|-------------|
| `<Leader>yp` | Yank Path | Copy filepath to clipboard (git-relative) |
| `<Leader>yl` | Yank Location | Copy filepath:line to clipboard |
| `<Leader>yd` | Yank Diagnostic | Copy diagnostic message to clipboard |
| `<Leader>yc` (visual) | Yank with Context | Copy selection with file context header |

## Terminal

| Key | Name | Description |
|-----|------|-------------|
| `<Leader>tv` | Terminal Vsplit | Open terminal in vertical split |
| `<Leader>ts` | Terminal Split | Open terminal in horizontal split |
| `<Leader>q` (terminal) | Close Terminal | Close terminal window |
| `<ESC>` (terminal) | Normal Mode | Switch to normal mode in terminal |
| `<C-h/j/k/l>` (terminal) | Navigate | Navigate out of terminal to other splits |

## Testing (Neotest)

| Key | Name | Description |
|-----|------|-------------|
| `<Leader>tn` | Test Nearest | Run nearest test |
| `<Leader>tf` | Test File | Run all tests in file |
| `<Leader>tl` | Test Last | Re-run last test |
| `<Leader>ta` | Test All | Toggle test summary panel |
| `<Leader>to` | Test Output | Open test output |
| `<Leader>tO` | Test Output Panel | Toggle test output panel |
| `<Leader>tS` | Test Stop | Stop running test |

## Go Development

| Key | Name | Description |
|-----|------|-------------|
| `<Leader>b` | Go Build | Build/test compile based on file type |

## Alternate Files (other.nvim)

The "other file" is a related file to the one you're editing. This plugin automatically detects file pairs based on naming conventions:

**Configured patterns:**
- **Go:** `main.go` ↔ `main_test.go` (implementation ↔ test file)
- **Rails:** Controllers ↔ Views, Models ↔ Specs (built-in)
- **Livewire:** Components ↔ Views (built-in)

**Example:** If you're editing `user.go`, pressing `,ll` will open `user_test.go` (and vice versa).

| Key | Name | Description |
|-----|------|-------------|
| `<Leader>ll` | Other File | Switch to the related file |
| `<Leader>lh` | Other (split) | Open related file in horizontal split |
| `<Leader>lv` | Other (vsplit) | Open related file in vertical split |
| `<Leader>ln` | Other (tab) | Open related file in new tab |
| `<Leader>lt` | Other Test | Specifically switch to the test file |
| `<Leader>lc` | Other Clear | Clear the file mapping cache |

You can also use the `:A` command (or `:AV`, `:AS`, `:AT` for splits/tabs).

## Surround (mini.surround)

| Key | Name | Description |
|-----|------|-------------|
| `gsa` | Add Surrounding | Add surrounding in Normal/Visual modes |
| `gsd` | Delete Surrounding | Delete surrounding characters |
| `gsr` | Replace Surrounding | Replace surrounding characters |
| `gsf` | Find Surrounding | Find surrounding (to the right) |
| `gsF` | Find Surrounding Left | Find surrounding (to the left) |
| `gsh` | Highlight Surrounding | Highlight surrounding |
| `gsn` | Update n_lines | Update search scope |

## Split/Join

| Key | Name | Description |
|-----|------|-------------|
| `gS` | Split Line | Split single line into multiple |
| `gJ` | Join Lines | Join multiple lines into one |

## Task Runner (Overseer)

| Key | Name | Description |
|-----|------|-------------|
| `<Leader>ot` | Overseer Toggle | Toggle task runner panel |
| `<Leader>or` | Overseer Run | Run a task |
| `<Leader>oq` | Overseer Quick | Quick action on current task |
| `<Leader>oa` | Overseer Action | Task action menu |

## Treesitter Selection

| Key | Name | Description |
|-----|------|-------------|
| `<Space>` | Init/Expand Selection | Start or expand treesitter selection |
| `<BS>` | Shrink Selection | Shrink to previous node |
| `<Tab>` | Scope Expand | Expand to upper scope |

## Treesitter Text Objects

| Key | Name | Description |
|-----|------|-------------|
| `af` / `if` | Function | Around/inside function |
| `ac` / `ic` | Class | Around/inside class |
| `aa` / `ia` | Parameter | Around/inside parameter |
| `aB` / `iB` | Block | Around/inside block |
| `]]` / `[[` | Function Jump | Jump to next/prev function start |
| `][` / `[]` | Function End | Jump to next/prev function end |
| `<Leader>wn` | Swap Next | Swap parameter with next |
| `<Leader>wp` | Swap Prev | Swap parameter with previous |

## Oil File Explorer Keys

| Key | Name | Description |
|-----|------|-------------|
| `<CR>` | Select | Open file/directory |
| `<C-v>` | Vsplit | Open in vertical split |
| `<C-s>` | Split | Open in horizontal split |
| `<C-t>` | Tab | Open in new tab |
| `<C-p>` | Preview | Preview file |
| `<C-c>` | Close | Close Oil |
| `<C-r>` | Refresh | Refresh listing |
| `-` | Parent | Go to parent directory |
| `g.` | Toggle Hidden | Show/hide hidden files |
| `g?` | Help | Show Oil help |

## Completion (blink.cmp)

| Key | Name | Description |
|-----|------|-------------|
| `<CR>` | Accept | Accept completion |
| `<Tab>` | Next | Select next item |
| `<S-Tab>` | Previous | Select previous item |
| `<C-e>` | Cancel | Cancel completion |
| `<C-d>` | Scroll Up | Scroll documentation up |
| `<C-f>` | Scroll Down | Scroll documentation down |

## Copilot

### Getting Started

1. **Sign in to GitHub Copilot:**
   ```
   :Copilot auth
   ```
   This opens a browser to authenticate with your GitHub account. You'll get a device code to enter on the GitHub site.

2. **Check Copilot status:**
   ```
   :Copilot status
   ```
   Shows if Copilot is running and authenticated.

3. **Enable/Disable Copilot:**
   ```
   :Copilot enable
   :Copilot disable
   ```

Once signed in, Copilot suggestions appear automatically as you type (shown as ghost text). Use the keymaps below to accept suggestions.

### Keymaps

| Key | Name | Description |
|-----|------|-------------|
| `<C-l>` | Accept | Accept entire Copilot suggestion |
| `<M-w>` | Accept Word | Accept just the next word |
| `<M-l>` | Accept Line | Accept just the next line |
| `<M-]>` | Next | Cycle to next suggestion |
| `<M-[>` | Previous | Cycle to previous suggestion |

> **Note:** `<M-x>` means Alt+x on most systems. On macOS, you may need to configure your terminal to send Meta/Alt keys properly, or use Option+x if configured.
