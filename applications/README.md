# NixOS WebApp Manager

A specialized tool for adding new web applications to your NixOS `webapps.nix` module.

## Features

- **Intelligent URL Detection**: Automatically suggests appropriate icons, categories, and settings based on the URL
- **Smart Defaults**: Pre-configured settings for popular services (Gmail, GitHub, Discord, Spotify, etc.)
- **Proper Quoting**: Handles URLs with special characters (like # in Gmail URLs)
- **Safe Updates**: Creates backups before modifying files
- **Colorized Output**: Clear visual feedback with color-coded messages

## Installation

The tool is already available in your PATH as `add-webapp`:

```bash
# The tool is symlinked to ~/.local/bin/add-webapp
add-webapp --help
```

## Usage

### Basic Usage
```bash
add-webapp "App Name" "https://example.com"
```

### With Options
```bash
add-webapp "App Name" "https://example.com" [options]
```

### Options

- `--icon=<icon>` - Icon name (default: chromium or auto-detected)
- `--categories=<cat1,cat2>` - Categories (default: Network or auto-detected)
- `--comment=<comment>` - Custom comment
- `--class=<class>` - Startup WM Class
- `--flags=<flag1,flag2>` - Extra chromium flags
- `--mime=<type1,type2>` - MIME types
- `--write` - Write directly to webapps.nix (creates backup)
- `--help` - Show help message

## Examples

### Simple Examples
```bash
# Add Gmail (auto-detects mail icon and mailto MIME type)
add-webapp 'Gmail' 'https://mail.google.com'

# Add YouTube Music (auto-detects audio icon and AudioVideo category)
add-webapp 'YouTube Music' 'https://music.youtube.com'

# Add Discord (auto-detects discord icon and Network category)
add-webapp 'Discord' 'https://discord.com/app'
```

### Advanced Examples
```bash
# Custom dashboard with system icon and multiple categories
add-webapp 'Company Dashboard' 'https://dashboard.company.com' \
  --icon=preferences-system \
  --categories=System,Office

# Email client with custom flags and MIME type
add-webapp 'Proton Mail' 'https://mail.proton.me' \
  --flags=--new-window,--disable-web-security \
  --mime=x-scheme-handler/mailto

# Write directly to file (creates backup)
add-webapp 'Slack' 'https://slack.com/signin' --write
```

## Auto-Detection Features

The tool automatically detects appropriate defaults based on URL patterns:

### Email Services
- **Detected URLs**: `*mail*`, `*gmail*`, `*outlook*`, `*proton*`
- **Icon**: `mail-unread` or `mail-app`
- **Category**: `Network`
- **MIME Type**: `x-scheme-handler/mailto`

### Music Services
- **Detected URLs**: `*music*`, `*spotify*`, `*soundcloud*`
- **Icon**: `multimedia-audio-player` or service-specific
- **Category**: `AudioVideo`

### Development Tools
- **Detected URLs**: `*github*`, `*gitlab*`, `*bitbucket*`
- **Icon**: `web-browser`
- **Category**: `Development`

### Office Tools
- **Detected URLs**: `*docs*`, `*office*`, `*notion*`
- **Icon**: `x-office-document`
- **Category**: `Office`

### Chat/Communication
- **Detected URLs**: `*chat*`, `*discord*`, `*slack*`, `*teams*`
- **Icon**: Service-specific or `internet-chat`
- **Category**: `Network`

### Dashboards/Admin
- **Detected URLs**: `*dashboard*`, `*admin*`, `*panel*`
- **Icon**: `preferences-system`
- **Category**: `System`

## File Management

### Location
- **Target File**: `/home/lennon/dotfiles/nixos/etc/nixos/webapps.nix`
- **Backup**: `webapps.nix.backup` (created automatically with `--write`)

### Applying Changes
After adding a webapp, apply changes with:
```bash
sudo nixos-rebuild switch
```

Or use the shorthand alias:
```bash
switch
```

## Troubleshooting

### URLs with Special Characters
URLs containing `#`, quotes, or spaces are automatically quoted:
```bash
# This URL with # is handled correctly
add-webapp 'Gmail Inbox' 'https://mail.google.com/mail/u/0/#inbox'
```

### Validation
The tool validates URLs and adds `https://` if no protocol is specified:
```bash
# These are equivalent
add-webapp 'Example' 'example.com'
add-webapp 'Example' 'https://example.com'
```

### Backup Recovery
If something goes wrong, restore from backup:
```bash
cp /home/lennon/dotfiles/nixos/etc/nixos/webapps.nix.backup \
   /home/lennon/dotfiles/nixos/etc/nixos/webapps.nix
```

## Integration with NixOS

The tool is designed to work seamlessly with your existing NixOS configuration:

1. **Preserves Existing Entries**: Never overwrites existing webapps
2. **Follows Patterns**: Uses the same structure as your current webapps.nix
3. **Safe Editing**: Creates backups and validates input
4. **Git Integration**: Works with your dotfiles Git repository

## Files

- `/home/lennon/dotfiles/applications/add-webapp.sh` - Main script
- `/home/lennon/.local/bin/add-webapp` - Symlink for easy access
- `/home/lennon/dotfiles/applications/webapp-manager.py` - Python version (optional)

## Common Categories

Use these standard desktop entry categories:

- `Network` - Web browsers, email, chat
- `AudioVideo` - Media players, music streaming
- `Office` - Document editors, productivity tools
- `Development` - Code editors, version control
- `System` - Administration tools, dashboards
- `Graphics` - Image editors, design tools
- `Game` - Games and entertainment