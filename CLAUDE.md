# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Commands

### NixOS Configuration Management
- **Switch configuration**: `sudo nixos-rebuild switch` or use alias `switch`
- **Test configuration**: `sudo nixos-rebuild test` or use alias `test-config`  
- **Garbage collection**: `sudo nix-collect-garbage --delete-older-than 30d` or use alias `gc`

### Git Operations
- Git is configured globally in the NixOS configuration with safe.directory for /etc/nixos
- Core filemode is disabled for better compatibility

## Architecture Overview

This is a **NixOS dotfiles repository** organized around a modular configuration system:

### Core Structure
- **Main config**: `/nixos/etc/nixos/configuration.nix` - Primary NixOS system configuration
- **Modular configs**: 
  - `vim.nix` - Vim editor configuration with plugins and customizations
  - `standardnotes.nix` - Standard Notes app with Wayland support
  - `syncthing.nix` - File synchronization service (present but not imported)

### Desktop Environment
- **Window Manager**: Niri (Wayland-based, enabled but Hyprland is disabled)
- **Display Manager**: SDDM with Wayland support
- **Terminal**: Kitty
- **Application Launcher**: Fuzzel
- **Status Bar**: Waybar
- **File Manager**: Nautilus + Ranger

### Key Application Directories
- `/hypr/` - Hyprland configuration files and wallpapers
- `/kitty/` - Terminal emulator configuration  
- `/waybar/` - Status bar configuration
- `/niri/` - Niri window manager configuration
- `/fuzzel/` - Application launcher configuration
- `/espanso/` - Text expander configuration
- `/lazygit/` + `/lazydocker/` - Git and Docker TUI configurations
- `/ranger/` - File manager configuration
- `/fzf/` - Fuzzy finder configuration

### System Features
- **Container Support**: Docker enabled with user in docker group
- **Audio**: PipeWire with ALSA and Pulse compatibility
- **Development Tools**: claude-code, rust-analyzer, nil (Nix LSP), git, fzf, zoxide
- **Wayland Integration**: Full Wayland environment with proper portal support

### Configuration Pattern
The repository follows a **symlink-based dotfiles pattern** using GNU Stow (installed in system packages). Configuration files are managed through NixOS modules that can be imported into the main configuration.

### User Environment
- User: `lennon` with sudo access and docker group membership
- Shell: Bash with extensive aliases and fzf integration
- PATH includes `~/.local/bin` for user-local binaries