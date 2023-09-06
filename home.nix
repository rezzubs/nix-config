{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    qpwgraph
    obsidian
    rnote
    steam
  ];

  wayland.windowManager.hyprland = {
    # enable = true;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.git = {
    enable = true;
    userName = "rezzubs";
    userEmail = "marten.roots@gmail.com";
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    autocd = true;
    history = {
      size = 50000;
      save = 50000;
    };
    initExtra = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 15;
    };
    settings = {
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      window_padding_width = 15;
      linux_display_server = "x11";
    };
    theme = "Catppuccin-Mocha";
  };

  programs.starship.enable = true;

  home.stateVersion = "23.05";
}
