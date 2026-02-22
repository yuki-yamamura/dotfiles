#!/bin/bash

BASE_DIR=$(cd "$(dirname $0)/.." && pwd)

create_symlink() {
  source_path="$1"
  target_path="$2"
  
  target_dir=$(dirname "$target_path")
  mkdir -p "$target_dir"
  
  rm -f "$target_path"
  ln -sf "$source_path" "$target_path"
  echo "Linked: $source_path -> $target_path"
}

# Zsh
create_symlink "$BASE_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Git
create_symlink "$BASE_DIR/git/config" "$HOME/.config/git/config"
create_symlink "$BASE_DIR/git/ignore" "$HOME/.config/git/ignore"

# Tmux
create_symlink "$BASE_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Neovim
create_symlink "$BASE_DIR/nvim/init.vim" "$HOME/.config/nvim/init.vim"
create_symlink "$BASE_DIR/nvim/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"

# VSCode
create_symlink "$BASE_DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
create_symlink "$BASE_DIR/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
create_symlink "$BASE_DIR/vscode/snippets/global.code-snippets" "$HOME/Library/Application Support/Code/User/snippets/global.code-snippets"
create_symlink "$BASE_DIR/vscode/snippets/typescriptreact.json" "$HOME/Library/Application Support/Code/User/snippets/typescriptreact.json"

# Karabiner-Elements
create_symlink "$BASE_DIR/karabiner/alternatives.json" "$HOME/.config/karabiner/assets/complex_modifications/alternatives.json"
create_symlink "$BASE_DIR/karabiner/apps.json" "$HOME/.config/karabiner/assets/complex_modifications/apps.json"
create_symlink "$BASE_DIR/karabiner/fn.json" "$HOME/.config/karabiner/assets/complex_modifications/fn.json"
create_symlink "$BASE_DIR/karabiner/movements.json" "$HOME/.config/karabiner/assets/complex_modifications/movements.json"
create_symlink "$BASE_DIR/karabiner/vim.json" "$HOME/.config/karabiner/assets/complex_modifications/vim.json"

# Claude Code
create_symlink "$BASE_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
create_symlink "$BASE_DIR/claude/settings.json" "$HOME/.claude/settings.json"

# Claude Code commands
for command_file in "$BASE_DIR"/claude/commands/*.md; do
  if [ -f "$command_file" ]; then
    command_name=$(basename "$command_file")
    create_symlink "$command_file" "$HOME/.claude/commands/$command_name"
  fi
done

# Claude Code agents
for agent_file in "$BASE_DIR"/claude/agents/*.md; do
  if [ -f "$agent_file" ]; then
    agent_name=$(basename "$agent_file")
    create_symlink "$agent_file" "$HOME/.claude/agents/$agent_name"
  fi
done

# Claude Code skills (symlink each skill directory)
mkdir -p "$HOME/.claude/skills"
for skill_dir in "$BASE_DIR"/claude/skills/*/; do
  if [ -d "$skill_dir" ]; then
    skill_name=$(basename "$skill_dir")
    rm -rf "$HOME/.claude/skills/$skill_name"
    ln -sf "$skill_dir" "$HOME/.claude/skills/$skill_name"
    echo "Linked: $skill_dir -> $HOME/.claude/skills/$skill_name"
  fi
done

# Yazi
create_symlink "$BASE_DIR/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"

# Lazygit
create_symlink "$BASE_DIR/lazygit/config.yml" "$HOME/Library/Application Support/lazygit/config.yml"

# GitHub CLI
create_symlink "$BASE_DIR/gh/config.yml" "$HOME/.config/gh/config.yml"

# ccresume
create_symlink "$BASE_DIR/ccresume/config.toml" "$HOME/.config/ccresume/config.toml"

# Mise
create_symlink "$BASE_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"

# Scripts
if [ -d "$BASE_DIR/scripts" ]; then
  mkdir -p "$HOME/.local/bin"
  
  for script in "$BASE_DIR"/scripts/*.sh; do
    if [ -f "$script" ]; then
      # Make script executable
      chmod +x "$script"
      
      # Get script name without .sh extension
      script_name=$(basename "$script" .sh)
      
      # Create symlink
      create_symlink "$script" "$HOME/.local/bin/$script_name"
    fi
  done
fi
