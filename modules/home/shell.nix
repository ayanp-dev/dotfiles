# Shell, prompt, and SSH configuration
{ ... }:
{
  # =========================================
  # Shell Configuration (Zsh)
  # =========================================
  programs.zsh = {
    enable = true;

    # Quality-of-life plugins
    autosuggestion.enable = true;      # Historical command suggestions
    syntaxHighlighting.enable = true;  # Real-time syntax validation

    # Binds Ctrl+F to accept the current autosuggestion
    initContent = ''
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
  # SSH & Authentication
  # =========================================
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*".AddKeysToAgent = "yes";
  };
}
