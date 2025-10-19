{ config, pkgs, lib, ... }:

{
  # Enable Chromium with declarative configuration
  programs.chromium = {
    enable = true;
    
    # Default browser settings
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
    defaultSearchProviderSuggestURL = "https://duckduckgo.com/ac/?q={searchTerms}";
    
    # Privacy and security extensions + Dracula theme
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere
      "fmkadmapgofadopljbjfkapdkoienihi" # React Developer Tools
      "gfapcejdoghpoidkfodoiiffaaibpaem" # Dracula Dark Theme
    ];
    
    # Initial preferences - these will be set on first run
    initialPrefs = {
      # Privacy settings
      "profile.default_content_setting_values.notifications" = 2; # Block notifications
      "profile.default_content_settings.popups" = 0; # Block popups
      "profile.password_manager_enabled" = false; # Disable built-in password manager
      
      # Performance settings
      "profile.default_content_setting_values.plugins" = 1; # Allow plugins
      "hardware_acceleration_mode_enabled" = true;
      
      # Developer settings
      "devtools.preferences.currentDockState" = "\"bottom\"";
      "devtools.preferences.showWhitespacesInEditor" = "true";
      
      # Theme settings
      "extensions.theme" = {
        "id" = "gfapcejdoghpoidkfodoiiffaaibpaem";
        "use_system" = false;
      };
      
      # Dark mode preferences
      "browser.theme.uses_system_theme" = false;
      "ntp.custom_background_dict" = {
        "background_url" = "";
        "is_ntp_custom_background" = false;
      };
      
      # Wayland specific settings
      "browser.enable_spellchecking" = true;
      "enable_do_not_track" = true;
    };
    
    # Command line flags for better Wayland integration and dark mode
    extraOpts = {
      # Wayland support
      "enable-features" = "VaapiVideoDecoder,VaapiVideoEncoder,WebRTCPipeWireCapturer,WebUIDarkMode";
      "ozone-platform" = "wayland";
      "enable-wayland-ime" = true;
      
      # Dark mode enforcement
      "force-dark-mode" = true;
      
      # Performance optimizations
      "enable-gpu-rasterization" = true;
      "enable-zero-copy" = true;
      "ignore-gpu-blocklist" = true;
      
      # Privacy enhancements
      "disable-background-networking" = true;
      "disable-background-timer-throttling" = true;
      "disable-renderer-backgrounding" = true;
      "disable-backgrounding-occluded-windows" = true;
      "disable-features" = "TranslateUI,BlinkGenPropertyTrees";
    };
  };
  
  # Add chromium to systemPackages for launcher visibility
  environment.systemPackages = with pkgs; [
    chromium      # Browser binary for launchers
    chromedriver  # For Selenium testing
  ];
}