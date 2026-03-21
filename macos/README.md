# macOS

macOS desktop configuration using yabai, skhd, and Homebrew.

---

## Window Manager: yabai + skhd

yabai provides tiling/float window management. skhd provides global hotkey support.

```bash
brew install asmvik/formulae/yabai asmvik/formulae/skhd
```

### Two modes

| Mode | Layout | Extras | Config files |
|---|---|---|---|
| Minimal | Float, 16px gaps | None | `.yabairc`, `.skhdrc` |
| Full | Float, 10px gaps | SketchyBar (status bar), JankyBorders (window borders) | `yabai/yabairc`, `yabai/bordersrc`, `yabai/sketchybar/` |

`install.sh` prompts to select a mode during setup.

### Minimal yabai config
```bash
# ~/.yabairc
yabai -m config layout float
yabai -m config window_gap 16
yabai -m config top_padding 16
yabai -m config bottom_padding 16
yabai -m config left_padding 16
yabai -m config right_padding 16
yabai -m config focus_follows_mouse off
yabai -m config mouse_modifier fn
yabai -m config mouse_action1 move
yabai -m config mouse_action2 resize
```

### Full yabai config
```bash
# Matches Hyprland 10px outer gaps
yabai -m config layout float
yabai -m config window_gap 10
yabai -m config top_padding 10
yabai -m config bottom_padding 10
yabai -m config left_padding 10
yabai -m config right_padding 10
yabai -m config external_bar all:32:0   # reserve top for SketchyBar
yabai -m config mouse_modifier alt
yabai -m config mouse_action1 move
yabai -m config mouse_action2 resize
```

### JankyBorders (Full mode)
```bash
# ~/.config/borders/bordersrc — Everforest+Nord theme
borders \
  active_color=0xff81a1c1 \   # Nord blue
  inactive_color=0xff543a48 \ # Everforest muted
  width=2.0 \
  style=round
```

---

## skhd Keybindings

```bash
# ~/.skhdrc — workspace switching via scripts
ctrl + shift - 1 : "$DOTFILES/scripts/spaces.sh" west
ctrl + shift - 2 : "$DOTFILES/scripts/spaces.sh" north
ctrl + shift - 3 : "$DOTFILES/scripts/spaces.sh" east
ctrl + shift - 4 : "$DOTFILES/scripts/spaces.sh" priority
ctrl + shift - q : "$DOTFILES/scripts/spaces.sh" south
ctrl + shift - w : "$DOTFILES/scripts/spaces.sh" northwest
ctrl + shift - b : yabai -m config layout bsp && yabai -m space --balance
ctrl + shift - f : yabai -m config layout float
ctrl + shift - s : yabai -m config layout stack
```

---

## Window Rules

Shared across both yabai modes — float system dialogs and utilities:

```bash
yabai -m rule --add app="^System Settings$" manage=off
yabai -m rule --add app="^Calculator$" manage=off
yabai -m rule --add app="^Karabiner" manage=off
yabai -m rule --add app="^Activity Monitor$" manage=off
yabai -m rule --add app="^Disk Utility$" manage=off
yabai -m rule --add app="^Archive Utility$" manage=off
yabai -m rule --add app="^Installer$" manage=off
yabai -m rule --add app="^Font Book$" manage=off
yabai -m rule --add title="^(Info|Preferences|Settings)$" manage=off
yabai -m rule --add app="^Finder$" title="^(Copy|Connect|Move|Info|Pref)" manage=off
yabai -m rule --add app="^Firefox$" title="^(Picture-in-Picture)$" manage=off
yabai -m rule --add app="^Reminders$" manage=off
```

---

## Ghostty (macOS)

```ini
# ~/.config/ghostty/config — macOS-specific settings
font-family = CaskaydiaCove Nerd Font
font-size = 13
font-feature = -liga
window-padding-x = 8
window-padding-y = 6
window-decoration = true
window-theme = dark
background-opacity = 0.95
background-blur-radius = 20
unfocused-split-opacity = 0.9
cursor-style = block
cursor-style-blink = false
shell-integration = bash
copy-on-select = clipboard
mouse-hide-while-typing = true
confirm-close-surface = false
# Everforest+Nord palette — see shared ghostty config
```

---

## Bash (macOS)

```bash
# macos/.bashrc — sources shared rc_common.sh
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && \
  . "/opt/homebrew/etc/profile.d/bash_completion.sh"
[[ ":$PATH:" != *":/opt/homebrew/bin:"* ]] && export PATH="/opt/homebrew/bin:$PATH"
alias grep="/opt/homebrew/bin/ggrep"
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias duh='du -h -d 1'
source "$DOTFILES/rc_common.sh"
```

---

## Brew Packages

Package list in `brew.json`, installed via `cli.sh`:

```bash
source cli.sh
dotfiles install terminal   # bash, starship, ghostty, nerd fonts
dotfiles install desktop    # yabai, skhd, borders, sketchybar
```

### Categories

| Category | Packages |
|---|---|
| terminal | bash, bash-completion@2, grep, neovim, starship, ghostty, nerd fonts |
| desktop | mos, caffeine, alt-tab, skhd, yabai, borders, sketchybar |
| apps/dev | docker, node, vscodium, pyenv, go |
| apps/ai | cursor, claude-code, codex, opencode |
| apps/desktop | brave-browser, librewolf, zen, discord, proton-mail, signal, telegram |
| apps/nextcloud | nextcloud, obsidian, logseq |
