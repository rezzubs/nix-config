# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [
    "amdgpu"
  ];

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale & input
  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };

  # Display
  services.xserver = {
    enable = true;

    videoDrivers = [ "amdgpu" ];

    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    layout = "ee";
    xkbVariant = "us";
    autorun = true;
  };

  services.gnome = {
    core-utilities.enable = false;
  };

  qt.enable = true;
  qt.platformTheme = "gtk2";
  qt.style = "gtk2";

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
    gnomeExtensions.pop-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
    gnomeExtensions.vitals
    gnomeExtensions.rounded-corners
    gnomeExtensions.rounded-window-corners
    gnome.gnome-tweaks
    gnome.nautilus
    nautilus-open-any-terminal
    bibata-cursors
    tela-circle-icon-theme
    adw-gtk3
    adwaita-qt

    neovim
    wl-clipboard
    killall
    zellij
    bat
    exa

    git
    ripgrep
    skim
    neofetch
    du-dust
    btop

    gcc
    rustup
    ghc
    haskell-language-server
    python3

    brave
  ];

  system.autoUpgrade.enable = true;

  # Shell Stuff
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions = {
      enable = true;
    };
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  environment.shellAliases = {
    cat = "bat";
    ls = "exa";
    lsl = "ls -l";
    lsa = "ls -a";
    lsla = "ls -la";
    nv = "nvim";
  };

  # Misc Programs
  programs.gamemode.enable = true;

  # Steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    nerdfonts
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

