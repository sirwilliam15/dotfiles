# Theme: Everforest Dark

> **Quick ref for agents:** Pure Everforest Dark Hard — warm, organic, forest-inspired. No Nord influence. All accents from the Everforest palette. Feels natural and earthy.

---

## Color Palette

### Backgrounds & Surfaces
| Role | Hex | Notes |
|---|---|---|
| Background | `#1e2326` | Dark Hard base |
| Surface | `#272e33` | Panels, sidebars, status bar |
| Overlay | `#2d3b41` | Dropdowns, tooltips, selections |

### Text
| Role | Hex | Notes |
|---|---|---|
| Primary text | `#d3c6aa` | Warm off-white |
| Muted text | `#7a8478` | Grey-green subtle |
| Bright text | `#d3c6aa` | Same as primary (no Nord snow) |

### Accent Colors
| Role | Hex | Usage |
|---|---|---|
| Primary accent | `#a7c080` | Green — active borders, success, directory, strings |
| Secondary accent | `#7fbbb3` | Blue — focus borders, properties, links |
| Tertiary accent | `#83c092` | Teal — functions, decorators, info |

### Semantic Colors
| Role | Hex | Usage |
|---|---|---|
| Green | `#a7c080` | Strings, git added, success, primary accent |
| Teal | `#83c092` | Functions, decorators, regex, `this`/`self` |
| Blue | `#7fbbb3` | Properties, headings, imports, links |
| Yellow | `#dbbc7f` | Types, warnings, TODOs |
| Orange | `#e69875` | Operators, escape chars, tag attributes |
| Red | `#e67e80` | Keywords, errors, git deleted, urgency |
| Purple | `#d699b6` | Numbers, constants, CSS values |

### Inactive / Muted
| Role | Hex |
|---|---|
| Inactive border | `#543a48` |
| Indent guides / dividers | `#2d3b41` |
| Scrollbar / faint UI | `#7a847830` |

---

## Component Application

### Hyprland
```
Active border:   rgb(a7c080)              (solid Everforest green)
Inactive border: rgb(543a48)
```

### Waybar
```
Background:      #1e2326
Text:            #d3c6aa
Active workspace:#a7c080
Inactive:        #7a8478
Urgent:          #e67e80
```

### Rofi
```
Background:      #1e2326
Text:            #d3c6aa
Selection bg:    #2d3b41
Selection border:#a7c080
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
Blue:            #7fbbb3 / #7fbbb3
Magenta:         #d699b6 / #d699b6
Cyan:            #83c092 / #83c092
White:           #d3c6aa / #d3c6aa
```

### Starship Prompt
```
Directory:       #a7c080 (green)
Git branch:      #7fbbb3 (blue)
Git status:      #e67e80 (red)
Success symbol:  #a7c080
Error symbol:    #e67e80
Duration:        #dbbc7f (yellow)
```

### tmux
```
Status bg:       #272e33
Status fg:       #d3c6aa
Session label:   #a7c080
Clock:           #7fbbb3
```

### GTK
```
Icon theme:      Papirus-Dark
Cursor:          Bibata-Modern-Classic    (warmer variant matches Everforest better)
Font:            Geist Mono 11
```

### swaync
```
Background:      #272e33
Text:            #d3c6aa
Action buttons:  #a7c080
Links:           #7fbbb3
```

### hyprlock
```
Background:      #1e2326
Input border:    #a7c080
Font:            Geist Mono
```

---

## Differences from Everforest Nord Blend
- **No Nord Frost colors** — all blues come from Everforest's own blue (`#7fbbb3`) and teal (`#83c092`)
- Functions use Everforest teal (`#83c092`) instead of Nord cyan (`#88c0d0`)
- Active border is solid green instead of a blue-green gradient
- Headings/imports use Everforest blue (`#7fbbb3`) instead of Nord blue (`#81a1c1`)
- Overall warmer and more muted feel — less contrast between accents and background
- Cursor theme: Bibata-Modern-Classic (warm) instead of Bibata-Modern-Ice (cool)
