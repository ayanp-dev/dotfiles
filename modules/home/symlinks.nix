# Dotfile symlinks and AI agent instructions
# Uses mkOutOfStoreSymlink for live editing without rebuilds
{ config, dotfilesPath, ... }:
let
  dotfiles = dotfilesPath;
in
{
  # =========================================
  # Dotfile Symlinks (live editing via mkOutOfStoreSymlink)
  # =========================================
  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/wezterm";

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/nvim";

  home.file.".config/herdr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/herdr";

  # =========================================
  # Antigravity CLI
  # =========================================
  home.file.".config/antigravity/statusline.sh".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/config/antigravity/statusline.sh";

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
