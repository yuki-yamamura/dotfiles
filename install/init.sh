#!/bin/bash

BASE_DIR=$(cd "$(dirname $0)/.." && pwd)

declare -A FILE_MAPPINGS=(
  ["$BASE_DIR/init.vim"]="$HOME/.config/nvim/init.vim"
  ["$BASE_DIR/vscode/settings.json"]="$HOME/Library/Application Support/Code/User/settings.json"
  ["$BASE_DIR/vscode/keybindings.json"]="$HOME/Library/Application Support/Code/User/keybindings.json"
  ["$BASE_DIR/vscode/snippets/global.code-snippets"]="$HOME/Library/Application Support/Code/User/snippets/global.code-snippets"
  ["$BASE_DIR/vscode/snippets/typescriptreact.json"]="$HOME/Library/Application Support/Code/User/snippets/typescriptreact.json"
  ["$BASE_DIR/karabiner/alternatives.json"]="$HOME/.config/karabiner/assets/complex_modifications/alternatives.json"
  ["$BASE_DIR/karabiner/apps.json"]="$HOME/.config/karabiner/assets/complex_modifications/apps.json"
  ["$BASE_DIR/karabiner/fn.json"]="$HOME/.config/karabiner/assets/complex_modifications/fn.json"
  ["$BASE_DIR/karabiner/movements.json"]="$HOME/.config/karabiner/assets/complex_modifications/movements.json"
  ["$BASE_DIR/karabiner/vim.json"]="$HOME/.config/karabiner/assets/complex_modifications/vim.json"
  ["$BASE_DIR/claude/CLAUDE.md"]="$HOME/.claude/CLAUDE.md"
  ["$BASE_DIR/claude/settings.json"]="$HOME/.claude/settings.json"
  ["$BASE_DIR/claude/react.md"]="$HOME/.claude/react.md"
  ["$BASE_DIR/claude/typescript.md"]="$HOME/.claude/typescript.md"
)

for source_path in "${!FILE_MAPPINGS[@]}"; do
  target_path="${FILE_MAPPINGS[$source_path]}"
  
  target_dir=$(dirname "$target_path")
  mkdir -p "$target_dir"
  
  rm -f "$target_path"
  ln -sf "$source_path" "$target_path"
  echo "Linked: $source_path -> $target_path"
done
