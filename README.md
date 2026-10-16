# sway-dotfiles

My Sway desktop, themed around a single palette taken from `foot.ini` (dark `#131318` background, soft purple accent) with 0.9 opacity on the terminal, launcher, notifications, and bar. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

Package names below are for **Arch / CachyOS**.

## What's inside

| Path | What it configures |
|------|--------------------|
| `.config/sway/` | Sway, split into `conf/` files: `var`, `autostart`, `decor`, `rules`, `output`, `input`, `binds` |
| `.config/waybar/` | Waybar config and CSS ("the wired" theme, Japanese labels) |
| `.config/foot/` | Terminal and the source palette for everything else |
| `.config/fuzzel/` | App launcher and the dmenu backend for the power menu |
| `.config/mako/` | Notifications |
| `.config/nvim/` | LazyVim with Kanagawa (dragon), transparent background |
| `.config/fish/` | Fish shell (sources the CachyOS fish config) and a custom prompt |
| `.config/fastfetch/` | Steins;Gate themed fetch |
| `.config/gowall/` | Custom `purpleforest` theme for gowall |
| `.local/bin/powermenu.sh` | Fuzzel power menu (logout, suspend, reboot, shutdown) |

## Packages

### Core (official repos)

```sh
sudo pacman -S --needed \
  sway waybar foot fuzzel mako \
  wl-clipboard cliphist grim slurp \
  pipewire pipewire-pulse wireplumber playerctl pwvucontrol \
  lxqt-policykit thunar \
  networkmanager network-manager-applet \
  fish fastfetch htop btop
```

| Package | Used for |
|---------|----------|
| `sway` | Compositor (also provides `swaymsg`, `swaynag`, and `/etc/sway/config.d/`) |
| `waybar` | Status bar (launched through `swaybar_command waybar`) |
| `foot` | Terminal |
| `fuzzel` | Launcher and power menu |
| `mako` | Notification daemon |
| `wl-clipboard`, `cliphist` | Clipboard history (`wl-paste --watch cliphist store` in autostart) |
| `grim`, `slurp` | Screenshots (region and full screen, copied to clipboard) |
| `pipewire`, `pipewire-pulse`, `wireplumber` | Audio; volume keys use `wpctl` |
| `playerctl` | Media keys |
| `pwvucontrol` | Volume mixer (waybar click, floating window rule). If pacman can't find it, it's in the AUR. |
| `lxqt-policykit` | Polkit agent (`lxqt-policykit-agent` in autostart) |
| `thunar` | File manager |
| `network-manager-applet` | `nm-connection-editor` (waybar network click) |
| `htop`, `btop` | Waybar memory and CPU clicks |
| `fish`, `fastfetch` | Shell and system info |

### Fonts, icons, cursor

```sh
sudo pacman -S --needed \
  ttf-jetbrains-mono-nerd noto-fonts-cjk \
  papirus-icon-theme bibata-cursor-theme
```

- **JetBrainsMono Nerd Font**: foot, fuzzel, mako, waybar, sway
- **Noto Sans CJK**: the Japanese labels in waybar
- **Papirus-Dark**: fuzzel icons
- **Bibata-Original-Classic**: cursor theme set in `conf/decor`

### Neovim (LazyVim)

```sh
sudo pacman -S --needed neovim git ripgrep fd gcc curl lazygit tree-sitter-cli
```

Needs a recent Neovim (0.11+). `lazy.nvim` bootstraps itself and installs LazyVim and Kanagawa on first launch. Install `nodejs npm` too if you want LSP servers installed through Mason.

### AUR

```sh
paru -S librewolf-bin gowall   # or yay
```

- **LibreWolf** is the default `$browser` in `conf/var` (or install it as a Flatpak).
- **gowall** is only needed if you use the theme in `.config/gowall/`. Alternative: `go install github.com/Achno/gowall@latest`.

### Fish

`config.fish` sources `/usr/share/cachyos-fish-config/cachyos-config.fish`.

- **CachyOS:** `sudo pacman -S cachyos-fish-config`
- **Vanilla Arch:** that file doesn't exist, so remove or replace the line in `config.fish`.

### Recommended (not referenced in a config)

```sh
sudo pacman -S --needed xdg-desktop-portal-wlr xdg-desktop-portal-gtk
```

Screen sharing under Sway needs `xdg-desktop-portal-wlr`, and `xdg-desktop-portal-gtk` handles file dialogs (there are window rules for them).

### Optional (only referenced by window rules)

`steam`, `gamescope`, `spotify`, `mpv`, `kitty`, `ark`, `qt5ct`, `qt6ct`, `kvantum`, `nwg-look`, `winetricks`, `protontricks`, `blueman`

## Install

```sh
sudo pacman -S git stow
git clone https://github.com/LeM0N7103/sway-dotfiles.git ~/dotfiles
cd ~/dotfiles
stow -nv .    # dry run, shows what would be linked
stow .
```

The repo mirrors your home directory (`.config/`, `.local/`), so it is stowed as a single package (`stow .`) and must live directly in `$HOME`. If it lives elsewhere, use `stow -t ~ .`.

If stow reports conflicts with existing files (for example a default `~/.config/foot/foot.ini`), move those away first.

## Before first launch

- **Monitors:** `conf/output` hardcodes `DP-1`, `DP-2`, and `HDMI-A-1` with resolutions, positions, and scales. Run `swaymsg -t get_outputs` and edit it. The `$MON1`, `$MON2`, `$MON3`, and `$PRIME_MON` variables in `conf/var` must match.
- **Wallpapers:** `conf/output` expects `~/Pictures/current_walls/DP_1.png`, `DP_2.png`, and `HDMI_A_1.png` (path set by `$wallpaper_path` in `conf/var`).
- **Waybar width:** `margin-left` and `margin-right` are set to `260` for a wide monitor, so lower them on a smaller screen.
- **Apps:** change `$term`, `$menu`, `$browser`, `$vol`, and `$file_manager` in `conf/var` if you use different programs.

## Keybinds

`$mod` is Super.

| Keys | Action |
|------|--------|
| `$mod+Return` | Terminal (foot) |
| `$mod+Space` | Launcher (fuzzel) |
| `$mod+e` / `$mod+w` | File manager / browser |
| `$mod+q` | Close window |
| `$mod+h/j/k/l` | Focus (add `Shift` to move) |
| `$mod+1..9` | Workspace (add `Shift` to send window) |
| `$mod+r` | Resize mode |
| `$mod+f` | Fullscreen |
| `$mod+Shift+s` | Screenshot region to clipboard |
| `$mod+F12` | Screenshot full screen to clipboard |
| `$mod+F7` | Volume mixer |
| `$mod+/`, `$mod+.`, `$mod+,` | Play/pause, next, previous |
| `Ctrl+Alt+m` | Power menu |
| `$mod+Shift+c` | Reload Sway |
| `$mod+Shift+e` | Exit Sway |

## Palette

From `foot.ini` (`[colors-dark]`):

| Role | Color |
|------|-------|
| Background | `#131318` |
| Background alt | `#1a1a23` |
| Foreground | `#f7f6f0` |
| Muted | `#656583` |
| Accent (purple) | `#b6a7ce` |
| Blue | `#b3c4e8` |
| Green | `#91a987` |
| Yellow | `#d2be98` |
| Red | `#cf676a` |
