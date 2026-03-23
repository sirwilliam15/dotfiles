# Theme: PlayStation Dark

> **Quick ref for agents:** PlayStation-inspired — deep blacks, cool greys, iconic button accents. Built around PS brand blue and the triangle/circle/cross/square colors. Feels sleek, modern, and bold.

---

## Color Palette

### PlayStation Palette Reference
```
Hardware (darks):        #101010  #1a1a1a  #2a2a2a  #3a3a3a
Interface (lights):      #c8c8c8  #d9d9d9  #eeeeee
Brand (blues):           #003791  #0070d1  #00439c  #005aa7
Buttons (accents):       #e60012  #ff7eb3  #00bc71  #0070d1  #9b59b6
```

### Backgrounds & Surfaces
| Role | Hex | PS Name |
|---|---|---|
| Background | `#101010` | Console Black |
| Surface | `#1a1a1a` | Matte Black |
| Overlay | `#2a2a2a` | Dark Grey |
| Bright overlay | `#3a3a3a` | Mid Grey |

### Text
| Role | Hex | PS Name |
|---|---|---|
| Primary text | `#c8c8c8` | Interface Light |
| Muted text | `#3a3a3a` | Mid Grey |
| Bright text | `#eeeeee` | Bright White |

### Accent Colors
| Role | Hex | PS Name | Usage |
|---|---|---|---|
| Primary accent | `#0070d1` | PS Blue | Active borders, headings, imports |
| Secondary accent | `#003791` | PS Deep Blue | Focus borders, buttons |
| Tertiary accent | `#005aa7` | PS Mid Blue | Functions, links, info |
| Warm accent | `#00439c` | PS Royal Blue | Hints, decorators, `this`/`self` |

### Semantic Colors
| Role | Hex | PS Name | Usage |
|---|---|---|---|
| Green | `#00bc71` | △ Triangle Green | Strings, git added, success |
| Yellow | `#f5a623` | PS Gold | Types, warnings, TODOs |
| Orange | `#ff7eb3` | □ Square Pink | Operators, escape chars, attributes |
| Red | `#e60012` | ○ Circle Red | Keywords, errors, git deleted, urgency |
| Purple | `#9b59b6` | PS Purple | Numbers, constants |

### Inactive / Muted
| Role | Hex |
|---|---|
| Inactive border | `#3a3a3a` |
| Indent guides / dividers | `#2a2a2a` |
| Scrollbar / faint UI | `#3a3a3a30` |

---

## Component Application

### Hyprland
```
Active border:   rgb(0070d1) rgb(005aa7) 45deg  (PS Blue -> PS Mid Blue gradient)
Inactive border: rgb(3a3a3a)
```

### Waybar
```
Background:      #101010
Text:            #c8c8c8
Active workspace:#0070d1
Inactive:        #3a3a3a
Urgent:          #e60012
```

### Rofi
```
Background:      #101010
Text:            #c8c8c8
Selection bg:    #2a2a2a
Selection border:#0070d1
Match highlight: #ff7eb3
```

### Ghostty / Terminal
```
Background:      #101010
Foreground:      #c8c8c8
Black:           #1a1a1a / #3a3a3a
Red:             #e60012 / #e60012
Green:           #00bc71 / #00bc71
Yellow:          #f5a623 / #f5a623
Blue:            #0070d1 / #0070d1
Magenta:         #ff7eb3 / #9b59b6
Cyan:            #005aa7 / #00439c
White:           #d9d9d9 / #eeeeee
```

### Starship Prompt
```
Directory:       #0070d1 (PS Blue)
Git branch:      #005aa7 (PS Mid Blue)
Git status:      #e60012 (Circle Red)
Success symbol:  #00bc71
Error symbol:    #e60012
Duration:        #f5a623 (PS Gold)
```

### tmux
```
Status bg:       #1a1a1a
Status fg:       #c8c8c8
Session label:   #0070d1
Clock:           #005aa7
```

### GTK
```
Icon theme:      Papirus-Dark
Cursor:          Bibata-Modern-Classic
Font:            Geist Mono 11
```

### swaync
```
Background:      #1a1a1a
Text:            #c8c8c8
Action buttons:  #00bc71
Links:           #0070d1
```

### hyprlock
```
Background:      #101010
Input border:    #0070d1
Font:            Geist Mono
```

---

## Differences from Nord Dark
- **Backgrounds are warmer/neutral** — true blacks (`#101010`) vs Nord's blue-grey (`#2e3440`)
- **Much higher contrast** — near-black backgrounds with lighter foreground text
- **Accent palette is brand-driven** — PS Blue (`#0070d1`) replaces Nord Frost blues
- **Button colors as semantics** — Triangle green, Circle red, Square pink map to semantic roles
- **PS Gold** (`#f5a623`) replaces Nord's Aurora Yellow for warnings/types
- **No cool blue-grey undertone** — neutral greys throughout instead of Nord's blue-tinted Polar Night
- Overall bolder, higher-contrast feel — sleek console aesthetic vs Nord's soft arctic tones
