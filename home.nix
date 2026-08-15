# ~/.dotfiles/home.nix
{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/Github/ayanp-dev/dotfiles";
in
{
  # =========================================
  # Core User Configuration
  # =========================================
  home.username = "ayan";
  home.homeDirectory = "/home/ayan";
  home.stateVersion = "26.05"; # Must match the system state version

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

  # =========================================
  # Shell Configuration (Zsh)
  # =========================================
  programs.zsh = {
    enable = true;

    # Quality-of-life plugins
    autosuggestion.enable = true;      # Historical command suggestions
    syntaxHighlighting.enable = true;  # Real-time syntax validation

    # Binds Ctrl+F to accept the current autosuggestion
    initExtra = ''
      bindkey '^f' autosuggest-accept
    '';

    # Workflow aliases
    shellAliases = {
      ".." = "cd ..";
      add  = "git add .";
      push = "git push";
      pull = "git pull";
      m    = "git switch main";
      cc   = "claude --dangerously-skip-permissions";
      co   = "codex --full-auto";
    };
  };
  
  # =========================================
  # SSH & Authentication
  # =========================================
  services.ssh-agent.enable = true;
  
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  # =========================================
  # Prompt Configuration (Starship)
  # =========================================
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };

  # =========================================
  # Symlinks & Dotfile Management
  # =========================================
  # Maps ~/.config/wezterm directly to the repository for live editing
  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/wezterm";

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/nvim";

  home.file.".config/herdr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/herdr";

  # Maps Claude Code settings
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/claude/settings.json"; 

  # =========================================
  # Global AI Agent Instructions
  # =========================================
  # Claude Code
  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/AGENTS.md";

  # OpenAI Codex
  home.file.".codex/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/AGENTS.md";

  # OpenCode
  home.file.".config/opencode/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/AGENTS.md";

  # Gemini CLI & Antigravity
  home.file.".gemini/GEMINI.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/AGENTS.md";

  home.file.".config/antigravity/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/AGENTS.md";
}
