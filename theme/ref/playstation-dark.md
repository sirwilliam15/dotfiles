# Theme: PlayStation Dark

> **Quick ref for agents:** High-contrast PlayStation-inspired dark theme. Keep the console-black base, use readable PS1 grey for muted text, reserve deep PS blue for filled controls, and use brighter PlayStation blues for code, diffs, and active UI.

---

## Color Palette

### PlayStation Palette Reference
```
Hardware darks:          #101114  #181a1f  #242832  #343944  #4b505c
PS1 greys / text:        #858a96  #8a8f9c  #9ea2ad  #d8d8dc  #f0f0f2
Brand blues:             #0057b8  #0b62c4  #4aa3ff  #7cb7ff
Code blues:              #6f96c7  #779dcc  #6ba7bf  #8497c5
Button accents:          #56d68a  #ff5f6d  #ff8fcb  #ffd166  #c792ea  #719e9a
```

### Backgrounds & Surfaces
| Role | Hex | PS Name |
|---|---|---|
| Background | `#101114` | Console Black |
| Surface | `#181a1f` | Matte Black |
| Overlay | `#242832` | PS1 Shadow Grey |
| Divider | `#343944` | Memory Card Grey |
| Bright overlay | `#4b505c` | Controller Grey |

### Text
| Role | Hex | PS Name |
|---|---|---|
| Primary text | `#d8d8dc` | PS1 Light Grey |
| Muted text | `#9ea2ad` | PS1 Mid Grey |
| Inactive text | `#8a8f9c` | Dim Controller Grey |
| Bright text | `#f0f0f2` | Disc White |

### Accent Colors
| Role | Hex | PS Name | Usage |
|---|---|---|---|
| Primary accent | `#4aa3ff` | PlayStation Blue | Active borders, badges, focus |
| Deep accent | `#0057b8` | Deep PS Blue | Buttons, remote status, filled controls |
| Hover accent | `#0b62c4` | Hover PS Blue | Button hover states |
| Code blue | `#6f96c7` | Muted PS Blue | Imports, macros, headings |
| Readable blue | `#779dcc` | DualShock Blue | Properties, changed files, JSON/YAML keys |
| Cyan blue | `#6ba7bf` | Soft Neon Blue | Functions, links, info |
| Soft blue | `#8497c5` | Analog Blue | Hints, builtins |

### Semantic Colors
| Role | Hex | PS Name | Usage |
|---|---|---|---|
| Green | `#56d68a` | Triangle Green | Strings, success, inserted lines |
| Bright green | `#6ee7a8` | Insert Green | Git added, diff added text |
| Yellow | `#ffd166` | PS Gold | Types, warnings, TODOs |
| Pink | `#ff8fcb` | Square Pink | Operators, escape chars, conflicts |
| Red | `#ff5f6d` | Circle Red | Keywords, errors, deleted lines |
| Soft red | `#ff7a89` | Delete Red | Git deleted text |
| Purple | `#c792ea` | PS Purple | Numbers, constants |
| Teal | `#719e9a` | Retro Teal | Decorators, regex, untracked files |

### Inactive / Muted
| Role | Hex |
|---|---|
| Inactive text | `#8a8f9c` |
| Muted readable text | `#9ea2ad` |
| Indent guides / dividers | `#343944` |
| Scrollbar / faint UI | `#4b505c30` |

---

## VS Code Contrast Rules

- Do not use legacy brand blues like `#003791`, `#00439c`, or `#005aa7` for syntax text on dark backgrounds; they are too low contrast.
- Use `#6f96c7`, `#779dcc`, or `#6ba7bf` for readable blue text in code; reserve `#4aa3ff` for UI accents.
- Use `#9ea2ad` for comments and secondary text; avoid `#3a3a3a` for anything that must be read.
- Use explicit diff backgrounds:
  - Inserted lines: `#133d2a66`
  - Inserted text: `#2f8f5f80`
  - Removed lines: `#4a162066`
  - Removed text: `#bf304580`
- Merge conflicts should have visible borders:
  - Current side: green headers/content
  - Incoming side: blue headers/content
  - Unhandled conflicts: `#ff8fcb`
  - Handled conflicts: `#56d68a`

---

## Component Application

### Hyprland
```
Active border:   rgb(4aa3ff) rgb(56d68a) 45deg  (PS Blue -> Triangle Green gradient)
Inactive border: rgb(343944)
```

### Waybar
```
Background:      #101114
Text:            #d8d8dc
Active workspace:#4aa3ff
Inactive:        #8a8f9c
Urgent:          #ff5f6d
```

### Rofi
```
Background:      #101114
Text:            #d8d8dc
Selection bg:    #28384d
Selection border:#4aa3ff
Match highlight: #ff8fcb
```

### Ghostty / Terminal
```
Background:      #101114
Foreground:      #d8d8dc
Black:           #181a1f / #9ea2ad
Red:             #ff5f6d / #ff7a89
Green:           #56d68a / #6ee7a8
Yellow:          #ffd166 / #ffe08a
Blue:            #4aa3ff / #7cb7ff
Magenta:         #ff8fcb / #c792ea
Cyan:            #5ad6ff / #64d8cb
White:           #d8d8dc / #f0f0f2
```

### Starship Prompt
```
Directory:       #4aa3ff (PlayStation Blue)
Git branch:      #7cb7ff (Readable blue)
Git status:      #ff5f6d (Circle Red)
Success symbol:  #56d68a
Error symbol:    #ff5f6d
Duration:        #ffd166 (PS Gold)
```

### tmux
```
Status bg:       #181a1f
Status fg:       #d8d8dc
Session label:   #4aa3ff
Clock:           #7cb7ff
```

### GTK
```
Icon theme:      Papirus-Dark
Cursor:          Bibata-Modern-Classic
Font:            Geist Mono 11
```

### swaync
```
Background:      #181a1f
Text:            #d8d8dc
Action buttons:  #56d68a
Links:           #5ad6ff
```

### hyprlock
```
Background:      #101114
Input border:    #4aa3ff
Font:            Geist Mono
```

---

## Differences from Nord Dark
- **Backgrounds stay neutral and dark** - console black and PS1 greys instead of Nord blue-grey.
- **Muted text is readable** - comments, line numbers, breadcrumbs, and inactive labels use PS1 grey rather than near-black grey.
- **Blue syntax uses brighter PlayStation blues** - deep brand blue is kept for filled controls, not code text.
- **Git and diff colors are explicit** - added, modified, deleted, untracked, and conflicting states have distinct readable foregrounds and backgrounds.
- **Merge conflicts are easier to scan** - current, incoming, handled, and unhandled regions have separate color treatments.
- **Controller accents remain semantic** - triangle green, circle red, square pink, PS gold, and purple still map to common language roles.
