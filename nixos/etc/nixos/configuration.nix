# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/vim.nix
      /etc/nixos/standardnotes.nix
      /etc/nixos/syncthing.nix
      /etc/nixos/yubikey_ssh_module.nix
      /etc/nixos/chromium.nix
      /etc/nixos/kitty.nix
      /etc/nixos/webapps.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";
 
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable Hyprland (Wayland compositor) - modern approach
  programs.hyprland = {
    enable = false;
    withUWSM = false;  # Universal Wayland Session Manager (recommended)
    xwayland.enable = false;
  };
  
  
  # Enable polkit for authentication
  security.polkit.enable = true;
  
  # Enable GNOME keyring for credential storage
  services.gnome.gnome-keyring.enable = true;
  
  # Enable XDG portal for niri
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
  
  # Wayland environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";  # Enable Wayland for Electron apps
    MOZ_ENABLE_WAYLAND = "1";  # Enable Wayland for Firefox
    XCURSOR_THEME = "Bibata-Modern-Classic";  # Set cursor theme
    XCURSOR_SIZE = "24";  # Set cursor size
    PATH = [ "$PATH" "$HOME/.local/bin" ];  # Add user local bin to PATH
  };

  # Configure keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lennon = {
    isNormalUser = true;
    description = "lennon allen";
    extraGroups = [ "networkmanager" "wheel" "docker" "input" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };


  # Enable SDDM display manager for niri
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  
  # Disable automatic login to show login screen
  # services.displayManager.autoLogin = {
  #   enable = true;
  #   user = "lennon";
  # };

  # Install firefox.
  programs.firefox.enable = true;

  # Configure git globally
  programs.git = {
    enable = true;
    config = {
      safe.directory = "/etc/nixos";
      core.filemode = false;
      user.name = "lennonallen";
      user.email = "lennonallen85@icloud.com";
    };
  };


  # Configure bash aliases and source fzf config
  programs.bash = {
    shellAliases = {
    ll = "ls -alF";
    la = "ls -A";
    l = "ls -CF";
    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    c = "clear";
    home = "cd && clear";
    switch = "sudo nixos-rebuild switch";
    test-config = "sudo nixos-rebuild test";
    gc = "sudo nix-collect-garbage --delete-older-than 30d";
    stow-nixos = "sudo stow -v -t / nixos";
    };
    interactiveShellInit = ''
      export PATH="$HOME/.local/bin:$PATH"
      # Source fzf configuration
      [ -f ~/.config/fzf/fzf.conf ] && source ~/.config/fzf/fzf.conf
    '';
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Existing packages
    claude-code
    lazygit
    lazydocker
    ranger
    niri                     # Niri window manager
    
    # Wayland essentials
    kitty                    # Modern terminal emulator
    nautilus                 # File manager
    fuzzel                   # Application launcher
    
    # Desktop utilities
    waybar                  # Status bar for Wayland
    dunst                   # Notification daemon
    grim                    # Screenshot utility
    slurp                   # Area selection for screenshots
    wl-clipboard           # Wayland clipboard utilities
    
    # Additional useful apps
    pavucontrol            # Audio control
    networkmanagerapplet   # Network manager tray
    brightnessctl          # Brightness control
    playerctl              # Media player control
    fzf                    # Fuzzy finder
    rust-analyzer          # Rust language server
    nil                    # Nix language server
    hyprpaper              # Wallpaper utility (works with niri too)
    zoxide
    obsidian
    todoist
    stow    
    tree
    btop
  ];

  virtualisation.docker.enable = true;
  
  programs.zoxide.enable = true; 

  # Enable niri window manager
  programs.niri.enable = true;

  # Fix git permissions for /etc/nixos
  systemd.tmpfiles.rules = [
    "Z /etc/nixos/.git 0755 lennon users - -"
    "Z /etc/nixos/.git/* 0644 lennon users - -"
  ];
  
  
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

