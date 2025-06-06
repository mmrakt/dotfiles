#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0) && pwd)

# vscode
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

rm "$VSCODE_SETTING_DIR/settings.json"
ln -s "$SCRIPT_DIR/.vscode/settings.json" "${VSCODE_SETTING_DIR}/settings.json"

rm "$VSCODE_SETTING_DIR/keybindings.json"
ln -s "$SCRIPT_DIR/.vscode/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"

# fish
rm -rf ~/.config/fish/
ln -s "$SCRIPT_DIR/.config/fish" ~/.config/fish/
