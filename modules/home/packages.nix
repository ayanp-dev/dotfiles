# User packages, fonts, and editor configuration
{ pkgs, ... }:
{
  # =========================================
  # User Packages
  # =========================================
  home.packages = with pkgs; [
    # CLI Utilities
    ripgrep      # Fast text search
    fd           # Fast filesystem find
    fzf          # Command-line fuzzy finder
    jq           # Command-line JSON processor
    lazygit      # Terminal UI for git
    neovim       # Text editor
    wezterm      # Terminal emulator
    wl-clipboard # Required for Neovim's 'unnamedplus' on Wayland
    

    # Fonts
    nerd-fonts.hack
  ];

  # Required for font discovery in Linux via Home Manager
  fonts.fontconfig.enable = true;
  
  # Default terminal editor
  home.sessionVariables.EDITOR = "nvim";  
}
