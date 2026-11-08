<h1 align="center">dotfiles</h1>

<p align="center">
  Personal dotfiles: Niri, Hyprland and Dux Shell on NixOS.
</p>

<p align="center">
  <img alt="Niri" src="https://img.shields.io/badge/Niri-KDL-e0a458">
  <img alt="Hyprland" src="https://img.shields.io/badge/Hyprland-Lua-58e1ff">
  <img alt="Shell" src="https://img.shields.io/badge/Shell-Dux-222222">
  <img alt="NixOS" src="https://img.shields.io/badge/NixOS-unstable-5277c3?logo=nixos&logoColor=white">
</p>

---

## 🗂️ What's inside

```
dotfiles/
├── hypr/                     # Hyprland (Lua config)
│   ├── hyprland.lua
│   └── hyprland_overrides/   # my binds, animations, layout and rules
└── niri/                     # Niri (KDL config)
    ├── config.kdl
    └── custom/               # my extras (outputs, layout, window rules)
```

Dux Shell generates its own files inside both folders (`dms/`). Those are
recreated automatically and ignored by Git.

## 🖥️ Monitor layout

| Monitor | Type | Scrolls | Window size |
|---|---|---|---|
| `DP-1` | 3440×1440 @ 240 Hz ultrawide | sideways → | ⅓ width |
| `DP-2` | 1920×1080 portrait | down ↓ | ½ height |

## 🔗 Setup

**On NixOS:** my [Nix repo](https://github.com/Raybird-io/nix) links these
folders into `~/.config` with home-manager (`users/kriss/symlinks.nix`).
Clone this repo to `~/dotfiles` and rebuild.

**Anywhere else:** clone and link the folders by hand:

```bash
git clone https://github.com/Raybird-io/dotfiles ~/dotfiles
ln -s ~/dotfiles/hypr ~/.config/hypr
ln -s ~/dotfiles/niri ~/.config/niri
```

The links are live: edits apply instantly, and apps can still save their settings.
