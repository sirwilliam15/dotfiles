# Theme: Nord Dark

> **Quick ref for agents:** Pure Nord — cool, clean, arctic-inspired. All colors from the official Nord palette. Feels crisp, minimal, and professional.

---

## Color Palette

### Nord Palette Reference
```
Polar Night (darks):     #2e3440  #3b4252  #434c5e  #4c566a
Snow Storm (lights):     #d8dee9  #e5e9f0  #eceff4
Frost (blues):           #8fbcbb  #88c0d0  #81a1c1  #5e81ac
Aurora (accents):        #bf616a  #d08770  #ebcb8b  #a3be8c  #b48ead
```

### Backgrounds & Surfaces
| Role | Hex | Nord Name |
|---|---|---|
| Background | `#2e3440` | Polar Night 1 |
| Surface | `#3b4252` | Polar Night 2 |
| Overlay | `#434c5e` | Polar Night 3 |
| Bright overlay | `#4c566a` | Polar Night 4 |

### Text
| Role | Hex | Nord Name |
|---|---|---|
| Primary text | `#d8dee9` | Snow Storm 1 |
| Muted text | `#4c566a` | Polar Night 4 |
| Bright text | `#eceff4` | Snow Storm 3 |

### Accent Colors
| Role | Hex | Nord Name | Usage |
|---|---|---|---|
| Primary accent | `#81a1c1` | Frost 3 | Active borders, headings, imports |
| Secondary accent | `#5e81ac` | Frost 4 | Focus borders, buttons |
| Tertiary accent | `#88c0d0` | Frost 2 | Functions, links, info |
| Warm accent | `#8fbcbb` | Frost 1 | Hints, decorators, `this`/`self` |

### Semantic Colors
| Role | Hex | Nord Name | Usage |
|---|---|---|---|
| Green | `#a3be8c` | Aurora Green | Strings, git added, success |
| Yellow | `#ebcb8b` | Aurora Yellow | Types, warnings, TODOs |
| Orange | `#d08770` | Aurora Orange | Operators, escape chars, attributes |
| Red | `#bf616a` | Aurora Red | Keywords, errors, git deleted, urgency |
| Purple | `#b48ead` | Aurora Purple | Numbers, constants |

### Inactive / Muted
| Role | Hex |
|---|---|
| Inactive border | `#4c566a` |
| Indent guides / dividers | `#434c5e` |
| Scrollbar / faint UI | `#4c566a30` |

---

## Component Application

### Hyprland
```
Active border:   rgb(81a1c1) rgb(88c0d0) 45deg  (Frost 3 -> Frost 2 gradient)
Inactive border: rgb(4c566a)
```

### Waybar
```
Background:      #2e3440
Text:            #d8dee9
Active workspace:#88c0d0
Inactive:        #4c566a
Urgent:          #bf616a
```

### Rofi
```
Background:      #2e3440
Text:            #d8dee9
Selection bg:    #434c5e
Selection border:#88c0d0
Match highlight: #d08770
```

### Ghostty / Terminal
```
Background:      #2e3440
Foreground:      #d8dee9
Black:           #3b4252 / #4c566a
Red:             #bf616a / #bf616a
Green:           #a3be8c / #a3be8c
Yellow:          #ebcb8b / #ebcb8b
Blue:            #81a1c1 / #81a1c1
Magenta:         #b48ead / #b48ead
Cyan:            #88c0d0 / #8fbcbb
White:           #e5e9f0 / #eceff4
```

### Starship Prompt
```
Directory:       #88c0d0 (Frost 2)
Git branch:      #81a1c1 (Frost 3)
Git status:      #bf616a (Aurora Red)
Success symbol:  #a3be8c
Error symbol:    #bf616a
Duration:        #ebcb8b (Aurora Yellow)
```

### tmux
```
Status bg:       #3b4252
Status fg:       #d8dee9
Session label:   #88c0d0
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
Background:      #3b4252
Text:            #d8dee9
Action buttons:  #a3be8c
Links:           #88c0d0
```

### hyprlock
```
Background:      #2e3440
Input border:    #88c0d0
Font:            Geist Mono
```

---

## Differences from Everforest Nord Blend
- **Backgrounds are cooler** — Nord Polar Night (`#2e3440`) is blue-grey vs Everforest's warm green-grey (`#1e2326`)
- **Text is cooler** — Nord Snow (`#d8dee9`) vs Everforest warm text (`#d3c6aa`)
- **Red is different** — Nord Aurora Red (`#bf616a`) is deeper/cooler vs Everforest Red (`#e67e80`) which is warmer/brighter
- **Green is different** — Nord Aurora Green (`#a3be8c`) is more muted vs Everforest Green (`#a7c080`) which is more vivid
- **No Everforest teal** — decorators use Frost 1 (`#8fbcbb`) instead
- **No warm muted purple** for inactive borders — uses Polar Night 4 (`#4c566a`) instead of `#543a48`
- Overall cooler, more monochromatic feel — everything shifts towards blue-grey
