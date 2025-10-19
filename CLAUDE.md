# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Commands

### NixOS Configuration Management
- **Switch configuration**: `sudo nixos-rebuild switch` or use alias `switch`
- **Test configuration**: `sudo nixos-rebuild test` or use alias `test-config`  
- **Garbage collection**: `sudo nix-collect-garbage --delete-older-than 30d` or use alias `gc`
- **Stow deployment**: `sudo stow -v -t / nixos` or use alias `stow-nixos` to deploy configurations

### Niri Window Manager Operations
- **Reload configuration**: `niri msg reload-config` - Apply changes to niri config without restart
- **Query outputs**: `niri msg outputs` - List available displays and their properties
- **Restart niri**: Log out and back in, or restart the display manager

### Git Operations
- Git is configured globally with safe.directory for /etc/nixos and core.filemode disabled
- Repository uses main branch as default
- User configured as "lennonallen" with email "lennonallen85@icloud.com"

## Architecture Overview

This is a **NixOS dotfiles repository** with a modular configuration system using symlink deployment via GNU Stow.

### Core NixOS Module Structure
The main configuration imports specialized modules:
- **`configuration.nix`** - Primary system configuration and package definitions
- **`vim.nix`** - Complete Vim setup with plugins (NERDTree, fzf-vim, fugitive, dracula theme)
- **`standardnotes.nix`** - Standard Notes with Wayland optimization wrapper
- **`syncthing.nix`** - File sync service with web app desktop entry (not currently imported)
- **`yubikey_ssh_module.nix`** - YubiKey SSH authentication module (configurable)

### NixOS Configuration Patterns
- **Module imports**: Each `.nix` file is a self-contained module that can be imported
- **Package customization**: Uses `symlinkJoin` and `makeWrapper` for app-specific modifications
- **System services**: Configured declaratively (pipewire, docker, niri, sddm)
- **User environment**: Bash aliases, fzf integration, PATH modifications via systemPackages

### Desktop Environment Architecture
- **Window Manager**: Niri (Wayland) - enabled, Hyprland disabled in config
- **Display Manager**: SDDM with Wayland support
- **Wayland Integration**: 
  - XDG portals via gnome-desktop-portal
  - Environment variables for Electron/Firefox Wayland support
  - Proper authentication via polkit and gnome-keyring

### Application Configuration Layout
```
/home/lennon/dotfiles/
├── nixos/etc/nixos/           # NixOS system configurations
├── niri/.config/niri/         # Window manager config (KDL format)
├── kitty/                     # Terminal configuration
├── waybar/                    # Status bar configuration  
├── fuzzel/                    # Application launcher
├── hypr/wallpapers/           # Wallpaper assets
├── lazygit/ + lazydocker/     # Development TUI configs
├── ranger/                    # File manager configuration
└── fzf/                       # Fuzzy finder configuration
```

### Key Niri Configuration Concepts
- **KDL format**: Uses KDL (https://kdl.dev) for configuration syntax
- **Hotkey structure**: `Modifier+Key { action; }` with overlay titles for help
- **Layout system**: Column-based tiling with preset widths and dynamic workspaces
- **Spawn actions**: Applications launched via `spawn` or `spawn-sh` commands
- **Wayland integration**: Screenshots, clipboard, portal support built-in

### System Integration Points
- **Stow deployment**: Configurations deployed to system via symlinks
- **Git permissions**: Systemd tmpfiles rules fix /etc/nixos/.git ownership  
- **Docker integration**: User in docker group, service enabled
- **Development tools**: rust-analyzer, nil (Nix LSP), fzf, zoxide pre-installed

### User Environment Configuration
- **User**: `lennon` with wheel, networkmanager, docker, input groups
- **Shell**: Bash with comprehensive aliases and fzf sourcing
- **PATH**: Extended with `~/.local/bin` for user binaries
- **Timezone**: America/Chicago with en_US.UTF-8 locale