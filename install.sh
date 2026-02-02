#!/usr/bin/env fish

echo "🔧 Installing dotfiles..."

# 実行権限
chmod +x $HOME/ghq/github.com/mmrakt/dotfiles/.bin/dev-setup.sh

# PATH追加
set config $HOME/.config/fish/config.fish
mkdir -p (dirname $config)

if not grep -q dotfiles/.bin $config 2>/dev/null
    echo 'set PATH $HOME/ghq/github.com/mmrakt/dotfiles/.bin $PATH' >> $config
    echo "✅ PATH added"
else
    echo "✅ PATH already set"
end

echo "🚀 Ready! Run: dev-setup"
