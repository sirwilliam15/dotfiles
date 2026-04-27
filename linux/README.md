# Linux

Linux desktop configuration using Hyprland on Wayland, targeting CachyOS (desktop) and Ubuntu Server 24.04 (server with desktop UI).

---

## Distros

### Personal Desktop — CachyOS (Arch-based)
- Rolling release, AUR access, gaming-optimised kernel
- Boot: Systemd-boot or GRUB (CachyOS default)
- Package manager: `pacman` + `yay`

### Server — Ubuntu Server 24.04 LTS
- 5-year LTS support, strong hardware compatibility
- Package manager: `apt`
- Install without a default DE (server ISO), layer Hyprland on top
- Disable unnecessary services (e.g. `snapd`)

---

## Shell Setup (all installs)

The repo's `install.sh` symlinks `starship.toml` and wires `rc_common.sh` into `~/.bashrc`, but it does **not** install `starship` itself. Install it once on any new machine — desktop or server — before opening a new shell.

### Install starship

**Ubuntu / Debian (server or desktop):**
```bash
curl -sS https://starship.rs/install.sh | sh
```

**Fedora:**
```bash
sudo dnf install -y starship
# or, if not in repos: curl -sS https://starship.rs/install.sh | sh
```

**Arch / CachyOS:**
```bash
sudo pacman -S starship
```

`rc_common.sh` guards the `starship init` call, so a missing binary is silent — but the prompt won't render until starship is installed.

### SSH from Ghostty into a server

Ghostty sets `TERM=xterm-ghostty`, which Ubuntu Server (and most stock distros) doesn't ship terminfo for. Without a fix, `clear`, `less`, `tmux`, and full-screen TUIs misbehave over SSH.

`rc_common.sh` falls back to `xterm-256color` automatically when `$SSH_CONNECTION` is set and the current `TERM` has no terminfo entry. That's the safe default.

To get full Ghostty fidelity (true colors, undercurl, etc.) on the server, install Ghostty's terminfo entry there once, from your **local** machine:

```bash
# from the local Ghostty client:
infocmp -x xterm-ghostty | ssh user@server -- tic -x -
```

After that, the fallback in `rc_common.sh` becomes a no-op for that host and `xterm-ghostty` works natively.

---

## Window Manager: Hyprland

- **Display protocol:** Wayland (XWayland enabled for legacy X11 apps)
- **Tiling mode:** Hybrid — tiling by default, float on demand
- **Same WM on both Linux machines**

### Installing Hyprland

**CachyOS:**
```bash
yay -S hyprland xdg-desktop-portal-hyprland
```

**Ubuntu Server 24.04:**
```bash
# Build from source or use a maintained PPA
# Required base packages:
sudo apt install -y wayland-protocols libwayland-dev libwlroots-dev \
  libxkbcommon-dev cmake meson ninja-build
```

> **Note:** Check the official Hyprland wiki for current Ubuntu build instructions.

---

## Desktop Stack (Hyprland Ecosystem)

All components are Wayland-native unless noted.

| Role | Component | Notes |
|---|---|---|
| Status bar | **Waybar** | CSS-styled, Hyprland workspace module enabled |
| App launcher | **Rofi** (Wayland build) | `rofi-wayland` package; replaces dmenu |
| Notification daemon | **swaync** | Notification center with history panel, toggle via keybind |
| Wallpaper daemon | **hyprpaper** | Config-driven, fast |
| Lock screen | **hyprlock** | GPU-accelerated, themed to match color palette |
| Idle daemon | **hypridle** | Dims at 5 min, locks at 10 min, suspends at 20 min |
| Display manager | **SDDM** | Themeable login screen |
| Screenshots | **grimblast** | Wrapper for grim + slurp; region, window, and fullscreen modes |
| Clipboard manager | **cliphist** + **wl-clipboard** | History via `cliphist`, Wayland backend via `wl-clipboard` |
| Polkit agent | **hyprpolkitagent** | Handles GUI authentication popups |

### CachyOS install:
```bash
yay -S waybar rofi-wayland swaync hyprpaper hyprlock hypridle sddm \
  grimblast-git cliphist wl-clipboard hyprpolkitagent
```

### Ubuntu install notes:
- Many packages need to be built from source or sourced from PPAs
- `sddm` is available in Ubuntu repos: `sudo apt install sddm`
- Check the Hyprland wiki for Ubuntu-specific instructions

---

## Hyprland Visual Behavior

```ini
# hyprland.conf — Visual settings

general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgb(81a1c1) rgb(a7c080) 45deg  # Nord blue → Everforest green gradient
    col.inactive_border = rgb(543a48)
    layout = dwindle
}

decoration {
    rounding = 8
    blur {
        enabled = true
        size = 4
        passes = 2
        new_optimizations = true
        xray = false
    }
    shadow {
        enabled = true
        range = 12
        render_power = 3
        color = rgba(0,0,0,0.4)
    }
    active_opacity = 1.0
    inactive_opacity = 0.95
}

animations {
    enabled = true
    bezier = snappy, 0.05, 0.9, 0.1, 1.0
    animation = windows, 1, 3, snappy
    animation = windowsOut, 1, 3, default, popin 80%
    animation = fade, 1, 3, snappy
    animation = workspaces, 1, 3, snappy, slide
}
```

**Summary:** 5px inner / 10px outer gaps, 2px gradient border (Nord blue → Everforest green), 8px rounded corners, subtle blur (size 4, 2 passes), soft shadows, snappy animations (~3 frames).

---

## Icon Theme & Cursor

- **Icon theme:** Papirus (Dark variant)
  ```bash
  # CachyOS
  yay -S papirus-icon-theme
  # Ubuntu
  sudo apt install papirus-icon-theme
  ```

- **Cursor:** Bibata Modern Ice (Nord-leaning)
  ```bash
  yay -S bibata-cursor-theme
  ```

- **GTK config:** Apply via `nwg-look` or manual `~/.config/gtk-3.0/settings.ini`

```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-icon-theme-name=Papirus-Dark
gtk-cursor-theme-name=Bibata-Modern-Ice
gtk-cursor-theme-size=24
gtk-font-name=Geist Mono 11
```

---

## Workspace & Behavior

### Modifier Key
- **Mod key:** `SUPER` (Windows/Meta key)

### Workspace Style
- **Dynamic workspaces** — created on demand, no fixed number
- Workspaces identified by number, not named
- Hyprland's default dynamic workspace behavior applies

### Monitor Support
```ini
# hyprland.conf — Monitor configuration
monitor = ,preferred,auto,1          # auto-detect all monitors
# For ultrawide (e.g. 3440x1440):
# monitor = DP-1, 3440x1440@144, 0x0, 1
# monitor = HDMI-A-1, 1920x1080@60, 3440x0, 1
```

### Window Rules (Auto-float)
```ini
windowrulev2 = float, class:^(pavucontrol)$
windowrulev2 = float, class:^(nm-connection-editor)$
windowrulev2 = float, title:^(Open File)$
windowrulev2 = float, title:^(Save File)$
windowrulev2 = float, class:^(xdg-desktop-portal-gtk)$
windowrulev2 = float, class:^(file-roller)$
windowrulev2 = float, class:^(thunar)$, title:^(File Operation Progress)$
windowrulev2 = center, floating:1
windowrulev2 = size 800 600, floating:1, class:^(pavucontrol|nm-connection-editor)$
```

### Window Swallowing
```ini
misc {
    enable_swallow = true
    swallow_regex = ^(ghostty|foot|kitty|alacritty)$
}
```

### Keybindings
```ini
$mod = SUPER
$terminal = ghostty
$launcher = rofi -show drun
$filemanager = thunar
$browser = firefox

# Core WM
bind = $mod, Return, exec, $terminal
bind = $mod, D, exec, $launcher
bind = $mod, Q, killactive
bind = $mod SHIFT, Q, exit
bind = $mod, F, fullscreen
bind = $mod SHIFT, Space, togglefloating
bind = $mod, P, pseudo

# Focus (vim keys)
bind = $mod, H, movefocus, l
bind = $mod, L, movefocus, r
bind = $mod, K, movefocus, u
bind = $mod, J, movefocus, d

# Move windows
bind = $mod SHIFT, H, movewindow, l
bind = $mod SHIFT, L, movewindow, r
bind = $mod SHIFT, K, movewindow, u
bind = $mod SHIFT, J, movewindow, d

# Resize
bind = $mod CTRL, H, resizeactive, -40 0
bind = $mod CTRL, L, resizeactive, 40 0
bind = $mod CTRL, K, resizeactive, 0 -40
bind = $mod CTRL, J, resizeactive, 0 40

# Workspaces
bind = $mod, 1, workspace, 1
bind = $mod, 2, workspace, 2
bind = $mod, 3, workspace, 3
bind = $mod, 4, workspace, 4
bind = $mod, 5, workspace, 5
bind = $mod SHIFT, 1, movetoworkspace, 1
bind = $mod SHIFT, 2, movetoworkspace, 2
bind = $mod SHIFT, 3, movetoworkspace, 3
bind = $mod SHIFT, 4, movetoworkspace, 4
bind = $mod SHIFT, 5, movetoworkspace, 5
bind = $mod, mouse_down, workspace, e+1
bind = $mod, mouse_up, workspace, e-1

# Scratchpad
bind = $mod, S, togglespecialworkspace, magic
bind = $mod SHIFT, S, movetoworkspecialworkspace, magic

# Screenshots (grimblast)
bind = , Print, exec, grimblast copy area
bind = SHIFT, Print, exec, grimblast copy screen
bind = $mod, Print, exec, grimblast copy active

# Clipboard history
bind = $mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy

# Notifications
bind = $mod SHIFT, N, exec, swaync-client -t

# Lock screen
bind = $mod, Escape, exec, hyprlock

# Volume & brightness
bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = , XF86MonBrightnessUp, exec, brightnessctl set 10%+
bindel = , XF86MonBrightnessDown, exec, brightnessctl set 10%-

# Mouse
bindm = $mod, mouse:272, movewindow
bindm = $mod, mouse:273, resizewindow
```

---

## Ghostty (Linux)

```ini
# ~/.config/ghostty/config
font-family = CaskaydiaCove Nerd Font
font-size = 13
font-feature = -liga
theme = everforest-dark-hard   # use built-in or define custom
background-opacity = 0.95
cursor-style = block
cursor-style-blink = false
window-decoration = false      # let Hyprland handle decorations
shell-integration = bash
```

> If `everforest-dark-hard` is not a built-in Ghostty theme, define a custom theme using the Everforest + Nord palette from the main README.

---

## tmux (Optional)

```bash
# ~/.config/tmux/tmux.conf
set -g prefix C-Space
set -g mouse on
set -g base-index 1
set -g default-terminal "ghostty"
set -ag terminal-overrides ",ghostty:RGB"
set -g status-style "bg=#272e33 fg=#d3c6aa"
set -g status-left "#[bold fg=#a7c080]  #S "
set -g status-right "#[fg=#81a1c1] %H:%M "
```

---

## Autostart

```ini
# hyprland.conf — Autostart
exec-once = hyprpolkitagent
exec-once = waybar
exec-once = hyprpaper
exec-once = hypridle
exec-once = swaync
exec-once = cliphist watch
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
```

---

## hypridle Config

```ini
# ~/.config/hypr/hypridle.conf
general {
    lock_cmd = pidof hyprlock || hyprlock
    before_sleep_cmd = loginctl lock-session
    after_sleep_cmd = hyprctl dispatch dpms on
}

listener {
    timeout = 300       # 5 min: dim screen
    on-timeout = brightnessctl -s set 20%
    on-resume = brightnessctl -r
}

listener {
    timeout = 600       # 10 min: lock
    on-timeout = loginctl lock-session
}

listener {
    timeout = 1200      # 20 min: suspend
    on-timeout = systemctl suspend
}
```

---

## SDDM Theme

- Recommended: `sddm-sugar-dark` or `sddm-astronaut-theme` with custom Everforest colors

```ini
# /etc/sddm.conf
[Theme]
Current=sugar-dark

[Autologin]
# Uncomment to enable autologin (server use case)
# User=yourusername
# Session=hyprland
```

---

## Environment Variables

```ini
# hyprland.conf — Environment
env = XCURSOR_THEME,Bibata-Modern-Ice
env = XCURSOR_SIZE,24
env = GDK_BACKEND,wayland,x11
env = QT_QPA_PLATFORM,wayland;xcb
env = QT_QPA_PLATFORMTHEME,qt6ct
env = SDL_VIDEODRIVER,wayland
env = CLUTTER_BACKEND,wayland
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland
env = MOZ_ENABLE_WAYLAND,1
```

---

## Package Lists

### CachyOS (Desktop) — Full Install
```bash
yay -S \
  hyprland xdg-desktop-portal-hyprland \
  waybar rofi-wayland swaync hyprpaper hyprlock hypridle \
  sddm grimblast-git cliphist wl-clipboard hyprpolkitagent \
  ghostty starship tmux \
  papirus-icon-theme bibata-cursor-theme nwg-look \
  ttf-geist-mono cascadia-code-nerd ttf-cascaydia-nerd \
  noto-fonts noto-fonts-emoji ttf-nerd-fonts-symbols \
  brightnessctl wireplumber pipewire pipewire-pulse \
  polkit-gnome dbus thunar
```

### Ubuntu Server 24.04 — Partial (many need PPAs or source builds)
```bash
sudo apt install -y \
  sddm waybar swaync wl-clipboard cliphist \
  starship tmux \
  papirus-icon-theme \
  fonts-noto fonts-noto-color-emoji \
  brightnessctl pipewire pipewire-pulse wireplumber \
  policykit-1-gnome dbus-x11 thunar
# Note: hyprland, rofi-wayland, ghostty, hyprlock, hypridle, hyprpaper,
# grimblast, and hyprpolkitagent must be sourced from PPAs or built from source
```

### Install fonts (CachyOS):
```bash
yay -S ttf-geist-mono ttf-cascaydia-nerd noto-fonts noto-fonts-emoji \
  ttf-nerd-fonts-symbols
```

---

## Agent Notes & Open Questions

1. **Geist font variant:** Geist Mono may feel tight at 11px in Waybar — consider Geist Sans for UI contexts.
2. **Waybar palette:** Background `#1e2326`, text `#d3c6aa`, Nord Frost accents for active states.
3. **Hyprlock theme:** Dark Everforest background, Geist Mono font, Nord blue input field border.
4. **Rofi theme:** Custom `.rasi` — Everforest+Nord palette, 8px rounded corners, blurred background, Nord Frost selection border.
5. **swaync CSS:** Dark background, Everforest green action buttons, Nord blue links.
6. **Ubuntu Hyprland install:** Check official Hyprland wiki for current Ubuntu build method. Avoid unmaintained PPAs.
7. **Monitor config:** Replace auto-detect with specific monitor identifiers from `hyprctl monitors` once running.
8. **Server autologin:** SDDM autologin config included but commented out — enable if desired.
