#!/usr/bin/env fish

echo "🔧 Installing dotfiles..."

# 実行権限
chmod +x $HOME/dotfiles/.bin/dev-setup

# PATH追加
set config $HOME/.config/fish/config.fish
mkdir -p (dirname $config)

if not grep -q dotfiles/.bin $config 2>/dev/null
    echo 'set PATH $HOME/dotfiles/.bin $PATH' >> $config
    echo "✅ PATH added"
else
    echo "✅ PATH already set"
end

echo "🚀 Ready! Run: dev-setup"
