# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # virtualisation
      ./virtualisation.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  security.polkit.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = rec {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = LC_ADDRESS;
    LC_MEASUREMENT = LC_ADDRESS;
    LC_MONETARY = LC_ADDRESS;
    LC_NAME = LC_ADDRESS;
    LC_NUMERIC = LC_ADDRESS;
    LC_PAPER = LC_ADDRESS;
    LC_TELEPHONE = LC_ADDRESS;
    LC_TIME = LC_ADDRESS;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";
  
  # Bluetooth
  hardware.bluetooth.enable = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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
  users.users.adrian = {
    isNormalUser = true;
    description = "adrian";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # desktop applications
      chromium
      # vscode config
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          jnoortheen.nix-ide
        ];
      })
      # emulators
      pcsx2
      pcsxr
      # terminal applications
      links2
      pfetch
      glances
      tmux
      nodejs
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. 
  environment.systemPackages = with pkgs; [
    neovim
    qemu
    virt-manager
    pciutils
    git
    wine
    # Lutris pkgs
    (lutris.override {
       extraPkgs = pkgs: [
         # List package dependencies here
         wine64
         winetricks
       ];
    })
    # Notes
    obsidian
    btrfs-progs
  ];

  programs = {
    noisetorch.enable = true;
    dconf.enable = true;
    steam.enable = true;
    # Shell aliases
    bash.shellAliases = {
      vim = "nvim";
      vi = "nvim";
    };
    # Tmux configuration
    tmux = {
      enable = true;
      extraConfig = ''
        set-option -g mouse on
        set -g status-right '#[fg=black,bg=color15] #{cpu_percentage} %H:%M '
        run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
      '';
    };
    chromium = {
      enable = true;
      extensions = [
        # Values can be found on the Chrome Webstore 
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
    };
  };

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
  
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 31d";
    };
  };
}
