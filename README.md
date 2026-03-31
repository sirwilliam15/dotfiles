# dotfiles

Shell configuration, install scripts, and desktop environment configs for macOS and Linux.

## Platforms

| Platform | Package Manager | WM | Terminal | Shell |
|---|---|---|---|---|
| macOS | Homebrew (`brew`) | yabai + skhd | Ghostty | Bash + Starship |
| Linux Desktop (CachyOS) | `pacman` + `yay` | Hyprland | Ghostty | Bash + Starship |
| Linux Server (Ubuntu 24.04) | `apt` | Hyprland | Ghostty | Bash + Starship |

See [macos/README.md](macos/README.md) and [linux/README.md](linux/README.md) for platform-specific details.

## Setup

### Quick start (new machine)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/sirwilliam15/dotfiles/HEAD/setup.sh)"
```

This installs Xcode CLI tools, Homebrew, git, and bash, then clones the repo to `~/.dotfiles`.

### Manual

```bash
git clone https://github.com/sirwilliam15/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` detects the platform via `$OSTYPE` and symlinks the appropriate configs. Existing files are backed up with a timestamp before overwriting.

### Package installation

```bash
source cli.sh
dotfiles install <list>    # e.g. "terminal", "desktop"
```

On macOS this uses `brew` with `macos/brew.json`. On Linux it detects `apt`/`dnf` from `/etc/os-release` and reads `linux/pkg.txt`.

---

## Color Palette

### Base Theme: Everforest + Nord Blend

A custom palette blending the warm greens and earth tones of Everforest with the cool blue-grey accents of Nord.

### Everforest Reference Colors (Dark Hard variant)
```
Background:  #1e2326
Surface:     #272e33
Overlay:     #2d3b41
Muted:       #543a48
Subtle:      #7a8478
Text:        #d3c6aa
Green:       #a7c080
Teal:        #83c092
Blue:        #7fbbb3
Yellow:      #dbbc7f
Orange:      #e69875
Red:         #e67e80
Purple:      #d699b6
```

### Nord Accent Colors (to blend in)
```
Nord Frost 1 (blue-grey): #8fbcbb
Nord Frost 2 (cyan):      #88c0d0
Nord Frost 3 (light blue):#81a1c1
Nord Frost 4 (deep blue): #5e81ac
Nord Snow 1 (off-white):  #d8dee9
```

### Blending Intent
- **Backgrounds & surfaces:** Use Everforest darks (`#1e2326`, `#272e33`)
- **Borders & active indicators:** Use Nord Frost blues (`#81a1c1`, `#5e81ac`) as primary accent
- **Text:** Everforest text (`#d3c6aa`) — warm, readable
- **Workspace indicators & highlights:** Nord Frost or Everforest Green (`#a7c080`)
- **Inactive borders:** Everforest Muted (`#543a48`) or Subtle (`#7a8478`)
- **Urgency/alerts:** Everforest Red (`#e67e80`)

Applied consistently across: Hyprland borders, Waybar CSS, Rofi theme, hyprlock, swaync CSS, Ghostty palette, JankyBorders, Starship prompt, VS Code theme, and SDDM.

Theme reference files are in `theme/ref/`.

---

## Fonts

| Role | Font | Notes |
|---|---|---|
| UI font (Waybar, Rofi, GTK) | **Geist Mono** | Monospace; use for UI labels and bar text |
| Terminal font | **CaskaydiaCove Nerd Font** | No ligatures; clean, readable |
| Fallback / emoji | **Noto Sans** + **Noto Color Emoji** | Broad Unicode coverage |
| Icon glyphs (Waybar) | **Nerd Fonts Symbols** | For status bar icons |

**Ligatures:** Disabled everywhere. No `font-feature-settings` for ligatures in terminal config.

---

## Terminal & Shell

### Terminal: Ghostty
- Config: `ghostty` (symlinked to `~/.config/ghostty/config`)
- Everforest + Nord color palette baked into the config
- CaskaydiaCove Nerd Font, size 13, ligatures off
- Platform differences handled in the config (e.g. `window-decoration = true` on macOS, `false` on Linux)

### Shell: Bash + Starship
- Prompt config: `theme/starship.toml` (symlinked to `~/.config/starship.toml`)
- Shared aliases and functions: `rc_common.sh` (sourced by platform-specific `.bashrc`)
- Platform `.bashrc` files: `macos/.bashrc`, `linux/.bashrc`

### Starship Prompt
```toml
# Two-line prompt with git info
# Colors: Everforest green (directory), Nord blue (branch), Everforest red (status)
format = """
[╭─](bold green)$directory$git_branch$git_status$cmd_duration
$line_break
[╰─](bold green)$character"""
```

---

## Theme Files

| File | Purpose |
|---|---|
| `theme/starship.toml` | Starship prompt config (shared) |
| `theme/vscode/` | VS Code/VSCodium Everforest-Nord theme extension |
| `theme/nvim-everforest-nord.lua` | Neovim colorscheme |
| `theme/obsidian.css` | Obsidian theme snippet |
| `theme/logseq.css` | Logseq theme snippet |
| `theme/ref/` | Color palette reference files |

---

## Directory Structure

```
dotfiles/
├── install.sh              # Platform-detecting installer (symlinks + backup)
├── cli.sh                  # Package installer helper (brew/apt/dnf)
├── rc_common.sh            # Shared shell config (aliases, env, starship init)
├── ghostty                 # Ghostty config (shared, macOS + Linux)
├── scripts/
│   ├── configure-repo.sh
│   ├── rebase.sh
│   └── spaces.sh           # macOS workspace switching
├── theme/
│   ├── starship.toml
│   ├── logseq.css
│   ├── obsidian.css
│   ├── nvim-everforest-nord.lua
│   ├── vscode/
│   │   ├── package.json
│   │   └── everforest-nord-theme.json
│   └── ref/
│       ├── everforest-dark.md
│       ├── everforest-nord-blend.md
│       └── nord-dark.md
├── macos/
│   ├── README.md
│   ├── .bashrc
│   ├── .skhdrc
│   ├── .yabairc
│   ├── brew.json
│   └── yabai/
│       ├── yabairc
│       ├── bordersrc
│       └── sketchybar/
└── linux/
    ├── README.md
    ├── .bashrc
    ├── pkg.txt
    ├── hypr/
    │   ├── hyprland.conf
    │   ├── hyprlock.conf
    │   ├── hypridle.conf
    │   └── hyprpaper.conf
    ├── waybar/
    │   ├── config.jsonc
    │   └── style.css
    ├── rofi/
    │   ├── config.rasi
    │   └── themes/everforest-nord.rasi
    ├── swaync/
    │   ├── config.json
    │   └── style.css
    ├── tmux/
    │   └── tmux.conf
    └── gtk/
        ├── gtk-3.0/settings.ini
        └── gtk-4.0/settings.ini
```
