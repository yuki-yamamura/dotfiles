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

# Create symlinks for each configuration file
create_symlink "$BASE_DIR/init.vim" "$HOME/.config/nvim/init.vim"
create_symlink "$BASE_DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
create_symlink "$BASE_DIR/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
create_symlink "$BASE_DIR/vscode/snippets/global.code-snippets" "$HOME/Library/Application Support/Code/User/snippets/global.code-snippets"
create_symlink "$BASE_DIR/vscode/snippets/typescriptreact.json" "$HOME/Library/Application Support/Code/User/snippets/typescriptreact.json"
create_symlink "$BASE_DIR/karabiner/alternatives.json" "$HOME/.config/karabiner/assets/complex_modifications/alternatives.json"
create_symlink "$BASE_DIR/karabiner/apps.json" "$HOME/.config/karabiner/assets/complex_modifications/apps.json"
create_symlink "$BASE_DIR/karabiner/fn.json" "$HOME/.config/karabiner/assets/complex_modifications/fn.json"
create_symlink "$BASE_DIR/karabiner/movements.json" "$HOME/.config/karabiner/assets/complex_modifications/movements.json"
create_symlink "$BASE_DIR/karabiner/vim.json" "$HOME/.config/karabiner/assets/complex_modifications/vim.json"
create_symlink "$BASE_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
create_symlink "$BASE_DIR/claude/settings.json" "$HOME/.claude/settings.json"
create_symlink "$BASE_DIR/claude/react.md" "$HOME/.claude/react.md"
create_symlink "$BASE_DIR/claude/typescript.md" "$HOME/.claude/typescript.md"

create_symlink "$BASE_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$BASE_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$BASE_DIR/.vimrc" "$HOME/.vimrc"

