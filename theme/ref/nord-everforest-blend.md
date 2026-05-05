# Theme: Nord Everforest Blend

> **Quick ref for agents:** This is the alternate theme — Nord Polar Night backgrounds with Everforest accent colors. Cool and structured with warm, natural highlights.

---

## Color Palette

### Backgrounds & Surfaces
| Role | Hex | Preview |
|---|---|---|
| Background | `#2e3440` | Nord Polar Night 1 base |
| Surface | `#3b4252` | Panels, sidebars, status bar |
| Overlay | `#434c5e` | Dropdowns, tooltips, selections |

### Text
| Role | Hex | Source |
|---|---|---|
| Primary text | `#d3c6aa` | Everforest text (warm off-white) |
| Muted text | `#7a8478` | Everforest subtle (grey-green) |
| Bright text | `#e5e9f0` | Nord Snow 2 (cool off-white) |

### Accent Colors
| Role | Hex | Source | Usage |
|---|---|---|---|
| Primary accent | `#83c092` | Everforest Teal | Active borders, tabs, headings, imports |
| Secondary accent | `#a7c080` | Everforest Green | Focus borders, buttons, deep highlights |
| Tertiary accent | `#7fbbb3` | Everforest Blue | Functions, links, info indicators |
| Warm accent | `#e69875` | Everforest Orange | Hints, secondary info |

### Semantic Colors
| Role | Hex | Source |
|---|---|---|
| Green | `#a3be8c` | Nord Aurora | Strings, git added, success, directory |
| Teal | `#8fbcbb` | Nord Frost 1 | Decorators, regex, `this`/`self` |
| Blue | `#81a1c1` | Nord Frost 3 | Properties, CSS properties |
| Yellow | `#ebcb8b` | Nord Aurora | Types, warnings, TODOs |
| Orange | `#d08770` | Nord Aurora | Operators, escape chars, tag attributes |
| Red | `#bf616a` | Nord Aurora | Keywords, errors, git deleted, urgency |
| Purple | `#b48ead` | Nord Aurora | Numbers, constants, CSS values |

### Inactive / Muted
| Role | Hex |
|---|---|
| Inactive border | `#4c566a` | Nord Polar Night 4 (cool grey) |
| Indent guides / dividers | `#434c5e` |
| Scrollbar / faint UI | `#7a847830` |

---

## Component Application

### Hyprland
```
Active border:   rgb(a7c080) rgb(81a1c1) 45deg  (Everforest green -> Nord blue gradient)
Inactive border: rgb(4c566a)
```

### Waybar
```
Background:      #2e3440
Text:            #d3c6aa
Active workspace:#83c092
Inactive:        #7a8478
Urgent:          #bf616a
```

### Rofi
```
Background:      #2e3440
Text:            #d3c6aa
Selection bg:    #434c5e
Selection border:#83c092
Match highlight: #e69875
```

### Ghostty / Terminal
```
Background:      #2e3440
Foreground:      #d3c6aa
Black:           #2e3440 / #4c566a
Red:             #bf616a / #bf616a
Green:           #a3be8c / #a3be8c
Yellow:          #ebcb8b / #ebcb8b
Blue:            #81a1c1 / #7fbbb3
Magenta:         #b48ead / #b48ead
Cyan:            #8fbcbb / #83c092
White:           #d3c6aa / #e5e9f0
```

### Starship Prompt
```
Directory:       #a3be8c (Nord green)
Git branch:      #83c092 (Everforest teal)
Git status:      #bf616a (Nord red)
Success symbol:  #a3be8c
Error symbol:    #bf616a
Duration:        #ebcb8b (Nord yellow)
```

### tmux
```
Status bg:       #3b4252
Status fg:       #d3c6aa
Session label:   #83c092
Clock:           #a7c080
```

### GTK
```
Icon theme:      Papirus-Dark
Cursor:          Bibata-Modern-Ice
Font:            Geist Mono 11
```

### swaync
```
Background:      #3b4252
Text:            #d3c6aa
Action buttons:  #83c092
Links:           #7fbbb3
```

### hyprlock
```
Background:      #2e3440
Input border:    #83c092
Font:            Geist Mono
```

---

## Design Notes
- Backgrounds are always Nord Polar Night — never Everforest darks
- Primary accent is always Everforest teal (`#83c092`), giving a warm natural feel against the cool Nord base
- Semantic colors (green, red, yellow, orange, purple) come from Nord Aurora
- Functions use Everforest blue (`#7fbbb3`) — the key differentiator from pure Nord
- The gradient active border (Everforest green -> Nord blue) is the signature visual, reversed from the primary theme
- Text stays warm Everforest (`#d3c6aa`) creating pleasant contrast against the cool backgrounds
