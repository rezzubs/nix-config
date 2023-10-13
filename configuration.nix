{ config, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Boot
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.kernelModules = [ "amdgpu" ];
  };

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "Europe/Tallinn";
  
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-mozc ];
    };
  };
  
  console = {
    keyMap = "us";
  };

  services.geoclue2.enable = true;

  # Display & Sound
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  services.xserver = {
    enable = true;
    #displayManager.startx.enable = true;
    displayManager.gdm.enable = true;
    #desktopManager.plasma5.enable = true;
    desktopManager.gnome.enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
    deviceSection = ''
      Option "TearFree" "true"
      Option "VariableRefresh" "true"
    '';
    layout = "ee";
    xkbVariant = "us";
  };

  services.getty.autologinUser = "rezzubs";

  services.pcscd.enable = true;
  
  services.hardware.openrgb.enable = true;
  
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # User Account
  users.users.rezzubs = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" "storage" ];
  };

  security.sudo.wheelNeedsPassword = false;

  # Run `nix-collect-garbage` automatically
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 7d";

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    gnomeExtensions.forge
    gnomeExtensions.gsconnect
    gnomeExtensions.rounded-corners
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.tiling-assistant
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.blur-my-shell
    gnome.gnome-tweaks

    kitty
    
    neovim
    git
    wl-clipboard
    killall
    zellij
    bat
    eza
    ripgrep
    skim
    neofetch
    du-dust
    btop

    brave

    gcc
    rustup
    ghc

    home-manager

    virt-manager
  ];

  system.autoUpgrade.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Shell Stuff
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      KDEWM = "${pkgs.haskellPackages.xmonad}/bin/xmonad";
    };
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    nerdfonts
  ];

  system.stateVersion = "23.05";
}
