{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.yubikey-ssh;
  
  # Edit these values after generating your YubiKey SSH key
  user = "lennon";
  publicKey = ''
    # Paste your YubiKey public key here after generating it
    # sk-ssh-ed25519@openssh.com AAAAC3Nza... your_email@example.com
  '';
  gitUserName = "Lennon Allen";
  gitUserEmail = "your_email@example.com";
in {
  options.services.yubikey-ssh = {
    enable = mkEnableOption "YubiKey SSH authentication";
  };

  config = mkIf cfg.enable {
    # Enable required services for YubiKey
    services.pcscd.enable = true;
    
    # Enable SSH agent
    programs.ssh.startAgent = true;

    # Install required packages
    environment.systemPackages = with pkgs; [
      yubikey-manager
      git
    ];

    # Configure SSH for GitHub with YubiKey
    programs.ssh.extraConfig = ''
      Host github.com
        IdentityFile ~/.ssh/id_ed25519_sk
    '';

    # Configure Git
    programs.git = {
      enable = true;
      config = {
        user.name = gitUserName;
        user.email = gitUserEmail;
        init.defaultBranch = "main";
      };
    };

    # Deploy public key to user's home directory
    system.activationScripts.yubikey-ssh-key = ''
      USER_HOME=$(eval echo ~${user})
      SSH_DIR="$USER_HOME/.ssh"
      
      # Create .ssh directory if it doesn't exist
      if [ ! -d "$SSH_DIR" ]; then
        mkdir -p "$SSH_DIR"
        chown ${user}:users "$SSH_DIR"
        chmod 700 "$SSH_DIR"
      fi
      
      # Deploy public key
      echo '${publicKey}' > "$SSH_DIR/id_ed25519_sk.pub"
      chown ${user}:users "$SSH_DIR/id_ed25519_sk.pub"
      chmod 644 "$SSH_DIR/id_ed25519_sk.pub"
    '';
  };
}
