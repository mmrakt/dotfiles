#!/bin/sh

# このスクリプトは、dotfilesの設定を復元するためのものです。
# 実行前に、既存の設定ファイルのバックアップが作成されます。
# 使用方法: ./restore.sh

set -e  # エラーが発生したら即座に終了

SCRIPT_DIR=$(cd $(dirname $0) && pwd)

# VSCode設定の復元
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

echo "VSCode設定を復元中..."
cp "${VSCODE_SETTING_DIR}/settings.json" "${VSCODE_SETTING_DIR}/settings.backup.json" || { echo "VSCode設定のバックアップに失敗しました"; exit 1; }
cp "${VSCODE_SETTING_DIR}/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.backup.json" || { echo "VSCodeキーバインドのバックアップに失敗しました"; exit 1; }

rm "$VSCODE_SETTING_DIR/settings.json"
ln -s "$SCRIPT_DIR/.vscode/settings.json" "${VSCODE_SETTING_DIR}/settings.json" || { echo "VSCode設定のシンボリックリンク作成に失敗しました"; exit 1; }

rm "$VSCODE_SETTING_DIR/keybindings.json"
ln -s "$SCRIPT_DIR/.vscode/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json" || { echo "VSCodeキーバインドのシンボリックリンク作成に失敗しました"; exit 1; }

# fish設定の復元
echo "fish設定を復元中..."
cp -r ~/.config/ ~/.config.backup/ || { echo "fish設定のバックアップに失敗しました"; exit 1; }

rm -rf ~/.config/fish/
ln -s "$SCRIPT_DIR/.config/fish" ~/.config/fish || { echo "fish設定のシンボリックリンク作成に失敗しました"; exit 1; }

# omf設定の復元
echo "omf設定を復元中..."
ln -s "$SCRIPT_DIR/.config/omf" ~/.config/omf || { echo "omf設定のシンボリックリンク作成に失敗しました"; exit 1; }

# gh設定の復元
echo "gh設定を復元中..."
ln -s "$SCRIPT_DIR/.config/gh" ~/.config/gh || { echo "gh設定のシンボリックリンク作成に失敗しました"; exit 1; }

# warp設定の復元
cp -r ~/.warp/ ~/.warp.backup/ || { echo "warp設定のバックアップに失敗しました"; exit 1; }
echo "warp設定を復元中..."
ln -s "$SCRIPT_DIR/.warp" ~/.warp || { echo "warp設定のシンボリックリンク作成に失敗しました"; exit 1; }

# claude設定の復元
cp -r ~/.claude/ ~/.claude.backup/ || { echo "claude設定のバックアップに失敗しました"; exit 1; }
echo "claude設定を復元中..."
ln -s "$SCRIPT_DIR/.claude/settings.json" ~/.claude/settings.json || { echo "claude設定のシンボリックリンク作成に失敗しました"; exit 1; }
ln -s "$SCRIPT_DIR/.claude/skills" ~/.claude/skills || { echo "claudeスキルのシンボリックリンク作成に失敗しました"; exit 1; }

# cursor設定の復元
CURSOR_SETTING_DIR=~/Library/Application\ Support/Cursor/User

echo "cursor設定を復元中..."
cp "${CURSOR_SETTING_DIR}/keybindings.json" "${CURSOR_SETTING_DIR}/keybindings.backup.json" || { echo "cursorキーバインドのバックアップに失敗しました"; exit 1; }
cp "${CURSOR_SETTING_DIR}/settings.json" "${CURSOR_SETTING_DIR}/settings.backup.json" || { echo "cursor設定のバックアップに失敗しました"; exit 1; }

rm "$CURSOR_SETTING_DIR/keybindings.json"
ln -s "$SCRIPT_DIR/.cursor/keybindings.json" "${CURSOR_SETTING_DIR}/keybindings.json" || { echo "cursorキーバインドのシンボリックリンク作成に失敗しました"; exit 1; }
rm "$CURSOR_SETTING_DIR/settings.json"
ln -s "$SCRIPT_DIR/.cursor/settings.json" "${CURSOR_SETTING_DIR}/settings.json" || { echo "cursor設定のシンボリックリンク作成に失敗しました"; exit 1; }


# uv global tools のインストール
if command -v uv > /dev/null 2>&1; then
    echo "uv global toolsをインストール中..."
    while IFS= read -r pkg || [ -n "$pkg" ]; do
        [ -z "$pkg" ] && continue
        uv tool install "$pkg" || echo "警告: $pkg のインストールに失敗しました"
    done < "$SCRIPT_DIR/uv-globals.txt"
else
    echo "警告: uvが見つかりません。uv-globals.txtのツールはスキップされました"
fi

echo "設定の復元が完了しました"





