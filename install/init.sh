#!/bin/bash

BASE_DIR=$(cd "$(dirname $0)/.." && pwd)
TARGET_FILE_PATHS=(
  ~/.zshrc
  ~/.vimrc
  ~/.config/nvim/init.vim
  ~/.tmux.conf
  ~/.gitconfig
  ~/Library/Application\ Support/Code/User/settings.json
  ~/Library/Application\ Support/Code/User/keybindings.json
  ~/Library/Application\ Support/Code/User/snippets/global.code-snippets
  ~/Library/Application\ Support/Code/User/snippets/typescriptreact.json
  ~/.config/karabiner/assets/complex_modifications/alternatives.json
  ~/.config/karabiner/assets/complex_modifications/apps.json
  ~/.config/karabiner/assets/complex_modifications/fn.json
  ~/.config/karabiner/assets/complex_modifications/movements.json
  ~/.config/karabiner/assets/complex_modifications/vim.json
)

for to_file_path in "${TARGET_FILE_PATHS[@]}"; do
  filename="$(basename "$to_file_path")"
  (
    cd ../
    from_file_path="$BASE_DIR/$(find .[!.]* * -type f -name "$filename")"
    rm -f "$to_file_path"
    ln -sf "$from_file_path" "$to_file_path"
  )
done
