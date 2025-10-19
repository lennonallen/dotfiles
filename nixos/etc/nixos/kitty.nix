# kitty.nix - NixOS system configuration for Kitty terminal
# Import this in configuration.nix with: imports = [ ./kitty.nix ];

{ config, lib, pkgs, ... }:

with lib;

let
  # Dracula theme colors
  draculaColors = {
    background = "#282a36";
    foreground = "#f8f8f2";
    selection_background = "#44475a";
    selection_foreground = "#f8f8f2";
    cursor = "#f8f8f2";
    cursor_text_color = "#282a36";
    
    # Normal colors
    color0 = "#21222c";   # black
    color1 = "#ff5555";   # red
    color2 = "#50fa7b";   # green
    color3 = "#f1fa8c";   # yellow
    color4 = "#bd93f9";   # blue
    color5 = "#ff79c6";   # magenta
    color6 = "#8be9fd";   # cyan
    color7 = "#f8f8f2";   # white
    
    # Bright colors
    color8 = "#6272a4";   # bright black
    color9 = "#ff6e6e";   # bright red
    color10 = "#69ff94";  # bright green
    color11 = "#ffffa5";  # bright yellow
    color12 = "#d6acff";  # bright blue
    color13 = "#ff92df";  # bright magenta
    color14 = "#a4ffff";  # bright cyan
    color15 = "#ffffff";  # bright white
  };


  kittyConfig = pkgs.writeText "kitty.conf" ''
    # Font configuration
    font_family      JetBrains Mono
    bold_font        JetBrains Mono Bold
    italic_font      JetBrains Mono Italic
    bold_italic_font JetBrains Mono Bold Italic
    font_size        12.0
    
    # Cursor
    cursor_shape beam
    cursor_beam_thickness 1.5
    cursor_blink_interval 0.5
    cursor_stop_blinking_after 15.0
    
    # Scrollback
    scrollback_lines 10000
    scrollback_pager less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER
    
    # Mouse
    mouse_hide_wait 3.0
    url_color #8be9fd
    url_style curly
    open_url_modifiers kitty_mod
    open_url_with default
    copy_on_select yes
    strip_trailing_spaces never
    select_by_word_characters @-./_~?&=%+#
    
    # Performance tuning
    repaint_delay 10
    input_delay 3
    sync_to_monitor yes
    
    # Window layout
    remember_window_size yes
    initial_window_width 1024
    initial_window_height 768
    enabled_layouts *
    window_resize_step_cells 2
    window_resize_step_lines 2
    window_border_width 0.5pt
    draw_minimal_borders yes
    window_margin_width 0
    single_window_margin_width -1
    window_padding_width 4
    placement_strategy center
    
    # Tab bar
    tab_bar_edge bottom
    tab_bar_margin_width 0.0
    tab_bar_style powerline
    tab_powerline_style slanted
    tab_title_template {title}{' :{}:'.format(num_windows) if num_windows > 1 else ''''}
    
    # Color scheme (Dracula)
    background ${draculaColors.background}
    foreground ${draculaColors.foreground}
    selection_background ${draculaColors.selection_background}
    selection_foreground ${draculaColors.selection_foreground}
    cursor ${draculaColors.cursor}
    cursor_text_color ${draculaColors.cursor_text_color}
    
    color0 ${draculaColors.color0}
    color1 ${draculaColors.color1}
    color2 ${draculaColors.color2}
    color3 ${draculaColors.color3}
    color4 ${draculaColors.color4}
    color5 ${draculaColors.color5}
    color6 ${draculaColors.color6}
    color7 ${draculaColors.color7}
    color8 ${draculaColors.color8}
    color9 ${draculaColors.color9}
    color10 ${draculaColors.color10}
    color11 ${draculaColors.color11}
    color12 ${draculaColors.color12}
    color13 ${draculaColors.color13}
    color14 ${draculaColors.color14}
    color15 ${draculaColors.color15}
    
    # Advanced
    shell .
    editor .
    close_on_child_death no
    allow_remote_control no
    update_check_interval 24
    startup_session none
    clipboard_control write-clipboard write-primary
    term xterm-kitty
    
    # OS specific
    wayland_titlebar_color system
    linux_display_server auto
    
    # Keyboard shortcuts
    kitty_mod ctrl+shift
    
    # Clipboard
    map kitty_mod+c copy_to_clipboard
    map kitty_mod+v paste_from_clipboard
    map kitty_mod+s paste_from_selection
    map shift+insert paste_from_selection
    
    # Scrolling
    map kitty_mod+up scroll_line_up
    map kitty_mod+k scroll_line_up
    map kitty_mod+down scroll_line_down
    map kitty_mod+j scroll_line_down
    map kitty_mod+page_up scroll_page_up
    map kitty_mod+page_down scroll_page_down
    map kitty_mod+home scroll_home
    map kitty_mod+end scroll_end
    map kitty_mod+h show_scrollback
    
    # Window management
    map kitty_mod+enter new_window
    map kitty_mod+n new_os_window
    map kitty_mod+w close_window
    map kitty_mod+] next_window
    map kitty_mod+[ previous_window
    map kitty_mod+f move_window_forward
    map kitty_mod+b move_window_backward
    map kitty_mod+` move_window_to_top
    map kitty_mod+r start_resizing_window
    map kitty_mod+1 first_window
    map kitty_mod+2 second_window
    map kitty_mod+3 third_window
    map kitty_mod+4 fourth_window
    map kitty_mod+5 fifth_window
    map kitty_mod+6 sixth_window
    map kitty_mod+7 seventh_window
    map kitty_mod+8 eighth_window
    map kitty_mod+9 ninth_window
    map kitty_mod+0 tenth_window
    
    # Tab management
    map kitty_mod+right next_tab
    map kitty_mod+left previous_tab
    map kitty_mod+t new_tab
    map kitty_mod+q close_tab
    map kitty_mod+. move_tab_forward
    map kitty_mod+, move_tab_backward
    map kitty_mod+alt+t set_tab_title
    
    # Layout management
    map kitty_mod+l next_layout
    
    # Font sizes
    map kitty_mod+equal change_font_size all +2.0
    map kitty_mod+minus change_font_size all -2.0
    map kitty_mod+backspace change_font_size all 0
    
    # Select and act on visible text
    map kitty_mod+e kitten hints
    map kitty_mod+p>f kitten hints --type path --program -
    map kitty_mod+p>shift+f kitten hints --type path
    map kitty_mod+p>l kitten hints --type line --program -
    map kitty_mod+p>w kitten hints --type word --program -
    map kitty_mod+p>h kitten hints --type hash --program -
    
    # Miscellaneous
    map kitty_mod+f11 toggle_fullscreen
    map kitty_mod+u kitten unicode_input
    map kitty_mod+f2 edit_config_file
    map kitty_mod+escape kitty_shell window
    map kitty_mod+a>m set_background_opacity +0.1
    map kitty_mod+a>l set_background_opacity -0.1
    map kitty_mod+a>1 set_background_opacity 1
    map kitty_mod+a>d set_background_opacity default
    map kitty_mod+delete clear_terminal reset active
  '';

in {
  options = {
    programs.kitty = {
      enable = mkEnableOption "Kitty terminal emulator with Dracula theme";
    };
  };

  config = {
    programs.kitty.enable = true;

    # Install Kitty and required fonts
    environment.systemPackages = with pkgs; [
      kitty
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];

    # System-wide Kitty configuration
    environment.etc."xdg/kitty/kitty.conf" = {
      source = kittyConfig;
      mode = "0644";
    };

    # Ensure proper font cache
    fonts = {
      packages = with pkgs; [
        jetbrains-mono
        nerd-fonts.jetbrains-mono
      ];
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [ "JetBrains Mono" ];
        };
      };
    };

    # Desktop entry for Kitty (if needed)
    environment.etc."xdg/applications/kitty-custom.desktop" = {
      text = ''
        [Desktop Entry]
        Version=1.0
        Type=Application
        Name=Kitty Terminal
        Comment=Fast, feature-rich, GPU based terminal
        Icon=kitty
        TryExec=kitty
        Exec=kitty
        Categories=System;TerminalEmulator;
        StartupNotify=true
        MimeType=application/x-shellscript;
        StartupWMClass=kitty
      '';
      mode = "0644";
    };

  };
}