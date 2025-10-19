# syncthing.nix - NixOS system configuration
# Import this in configuration.nix with: imports = [ ./syncthing.nix ];

{ config, pkgs, ... }:

{
  # Enable Syncthing service
  services.syncthing = {
    enable = true;
    user = "lennon";
    dataDir = "/home/lennon/Sync";
    configDir = "/home/lennon/.config/syncthing";
    
    # Open firewall ports for Syncthing
    openDefaultPorts = true;
    
    # Optional: Pre-configure devices and folders
    settings = {
      devices = {
        # "laptop" = { id = "DEVICE-ID-GOES-HERE"; };
        # "phone" = { id = "DEVICE-ID-GOES-HERE"; };
      };
      folders = {
        "Documents" = {
          path = "/home/lennon/Sync/Documents";
          devices = [ ]; # Add device names here: [ "laptop" "phone" ]
        };
      };
    };
  };

  # Ensure sync directories exist
  systemd.tmpfiles.rules = [
    "d /home/lennon/Sync 0755 lennon users - -"
    "d /home/lennon/Sync/Documents 0755 lennon users - -"
  ];

  # Create desktop entry for Syncthing web app
  environment.systemPackages = with pkgs; [
    (makeDesktopItem {
      name = "syncthing-webapp";
      desktopName = "Syncthing";
      comment = "Continuous file synchronization";
      exec = "${chromium}/bin/chromium --app=http://localhost:8384";
      icon = "syncthing";
      categories = [ "Network" "FileTransfer" ];
    })
  ];
}