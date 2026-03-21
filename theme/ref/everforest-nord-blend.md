# Theme: Everforest Nord Blend

> **Quick ref for agents:** This is the primary/default theme — Everforest Dark Hard backgrounds and text with Nord Frost accent colors. Warm and natural with a crisp, professional edge.

---

## Color Palette

### Backgrounds & Surfaces
| Role | Hex | Preview |
|---|---|---|
| Background | `#1e2326` | Everforest Dark Hard base |
| Surface | `#272e33` | Panels, sidebars, status bar |
| Overlay | `#2d3b41` | Dropdowns, tooltips, selections |

### Text
| Role | Hex | Source |
|---|---|---|
| Primary text | `#d3c6aa` | Everforest text (warm off-white) |
| Muted text | `#7a8478` | Everforest subtle (grey-green) |
| Bright text | `#d8dee9` | Nord Snow 1 (cool off-white) |

### Accent Colors
| Role | Hex | Source | Usage |
|---|---|---|---|
| Primary accent | `#81a1c1` | Nord Frost 3 | Active borders, tabs, headings, imports |
| Secondary accent | `#5e81ac` | Nord Frost 4 | Focus borders, buttons, deep highlights |
| Tertiary accent | `#88c0d0` | Nord Frost 2 | Functions, links, info indicators |
| Warm accent | `#8fbcbb` | Nord Frost 1 | Hints, secondary info |

### Semantic Colors
| Role | Hex | Source |
|---|---|---|
| Green | `#a7c080` | Everforest | Strings, git added, success, directory |
| Teal | `#83c092` | Everforest | Decorators, regex, `this`/`self` |
| Blue | `#7fbbb3` | Everforest | Properties, CSS properties |
| Yellow | `#dbbc7f` | Everforest | Types, warnings, TODOs |
| Orange | `#e69875` | Everforest | Operators, escape chars, tag attributes |
| Red | `#e67e80` | Everforest | Keywords, errors, git deleted, urgency |
| Purple | `#d699b6` | Everforest | Numbers, constants, CSS values |

### Inactive / Muted
| Role | Hex |
|---|---|
| Inactive border | `#543a48` | Everforest muted (warm purple-grey) |
| Indent guides / dividers | `#2d3b41` |
| Scrollbar / faint UI | `#7a847830` |

---

## Component Application

### Hyprland
```
Active border:   rgb(81a1c1) rgb(a7c080) 45deg  (Nord blue -> Everforest green gradient)
Inactive border: rgb(543a48)
```

### Waybar
```
Background:      #1e2326
Text:            #d3c6aa
Active workspace:#81a1c1
Inactive:        #7a8478
Urgent:          #e67e80
```

### Rofi
```
Background:      #1e2326
Text:            #d3c6aa
Selection bg:    #2d3b41
Selection border:#81a1c1
Match highlight: #e69875
```

### Ghostty / Terminal
```
Background:      #1e2326
Foreground:      #d3c6aa
Black:           #1e2326 / #7a8478
Red:             #e67e80 / #e67e80
Green:           #a7c080 / #a7c080
Yellow:          #dbbc7f / #dbbc7f
Blue:            #7fbbb3 / #81a1c1
Magenta:         #d699b6 / #d699b6
Cyan:            #83c092 / #88c0d0
White:           #d3c6aa / #d8dee9
```

### Starship Prompt
```
Directory:       #a7c080 (Everforest green)
Git branch:      #81a1c1 (Nord blue)
Git status:      #e67e80 (Everforest red)
Success symbol:  #a7c080
Error symbol:    #e67e80
Duration:        #dbbc7f (Everforest yellow)
```

### tmux
```
Status bg:       #272e33
Status fg:       #d3c6aa
Session label:   #a7c080
Clock:           #81a1c1
```

### GTK
```
Icon theme:      Papirus-Dark
Cursor:          Bibata-Modern-Ice
Font:            Geist Mono 11
```

### swaync
```
Background:      #272e33
Text:            #d3c6aa
Action buttons:  #a7c080
Links:           #88c0d0
```

### hyprlock
```
Background:      #1e2326
Input border:    #81a1c1
Font:            Geist Mono
```

---

## Design Notes
- Backgrounds are always Everforest darks — never Nord polar darks
- Primary accent is always Nord blue (`#81a1c1`), giving a crisp professional feel against the warm Everforest base
- Semantic colors (green, red, yellow, orange, purple) come from Everforest
- Functions use Nord cyan (`#88c0d0`) — the key differentiator from pure Everforest
- The gradient active border (Nord blue -> Everforest green) is the signature visual
